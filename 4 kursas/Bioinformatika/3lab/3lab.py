from Bio import SeqIO
from Bio import SearchIO
from Bio.Blast import NCBIWWW
from Bio.Align.Applications import MafftCommandline
from Bio import AlignIO
from Bio import Phylo
from Bio.Phylo.TreeConstruction import DistanceCalculator, DistanceTreeConstructor
from Bio.Alphabet import ProteinAlphabet
from Bio.Align import AlignInfo
from Bio import motifs
import matplotlib.pyplot
from os import path


class AlbuminAnalyzer:
    human_albumin = {}
    human_albumin_path = ''
    _albumins = []

    def __init__(self, albumin_file):
        self._human_albumin_path = albumin_file
        self.load_human_albumin()
        self.blast_result = []
        self.albumins = []

    def load_human_albumin(self):
        for seq in SeqIO.parse(self._human_albumin_path, "fasta"):
            self._human_albumin = seq

    def blast_search(self):
        if not path.exists("blast.xml"):
            result = NCBIWWW.qblast(program="blastp", database="swissprot", sequence=self._human_albumin.seq, perc_ident=80, entrez_query='mammals[Organism]')
            with open(".\\blast.xml", "w") as out:
                out.write(result.read())
            result.close()
        self._blast_result = SearchIO.read("blast.xml", "blast-xml") #BLAST paieskos gaunami rezultatai issaugomi blast.xml
        #print("Paieska baigta")

    def blast_results(self):
        with open("albumins.fasta", "w") as out:     #Atrinkti albuminai is BLAST paieskos rezultatu issaugomi faile albumins.fasta
            for hit in self._blast_result.hits:
                if "Albumin" in hit.description:
                    self._albumins.append(hit)
                    rec = hit.hsps[0].hit
                    SeqIO.write(rec, out, "fasta")
        #print("Rezultatai gauti")
        

    def mafft_alignment(self):
        mafft = "mafft-win\mafft.bat"
        file = "albumins.fasta"
        mafft_cline = MafftCommandline(mafft, input=file)
        stdout, stderr = mafft_cline()
        with open("mafft.fasta", "w") as out:       #maft.fasta faile issaugomas palyginys
            out.write(stdout)
        #print("Maft palyginys suskaiciuotas")
    
    def draw_tree(self):
        ali = AlignIO.read("mafft.fasta", "fasta")
        ali._alphabet = ProteinAlphabet()
        calculator = DistanceCalculator('blosum62')
        constructor = DistanceTreeConstructor(calculator)
        tree = constructor.build_tree(ali)
        Phylo.draw(tree)
        #print("Kur medis????")

    def information_content(self):
        ali = AlignIO.read("mafft.fasta", "fasta")
        ali._alphabet = ProteinAlphabet()
        human_index = -1
        mammals_index = -1
        max_information_content = -1
        min_information_content = 9999
        i = 0
        information_contents = []
        indices = []
        while i < len(ali[0]) - 14:
            info_content = AlignInfo.SummaryInfo(ali).information_content(i, i+14)
            information_contents.append(info_content)
            indices.append(i)
            if info_content > max_information_content:
                max_information_content = info_content
                mammals_index = i
            if info_content < min_information_content:
                min_information_content = info_content
                human_index = i
            i = i + 1
        print("Originaliausios zmogui sekos indeksas: ", human_index, "\nPanasiausios kitiems zinduoliams sekos indeksas: ", mammals_index)
        print("Originaliausia zmogui seka: ", self._human_albumin.seq[human_index:human_index + 15])
        print("Panasiausia kitiems zinduoliams seka: ", self._human_albumin.seq[mammals_index:mammals_index + 15])
        


analyzer = AlbuminAnalyzer('albumin_human.fasta')
analyzer.blast_search()
analyzer.blast_results()
analyzer.mafft_alignment()
analyzer.draw_tree()
analyzer.information_content()