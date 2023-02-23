import os 
from pathlib import Path
import shutil


# requiement: sra-toolkit  
def get_sra(sra_list,download_dir):
    '''
    Saved the input sra files into download directory
    Args:
        sra_list: SRR accession list or SRR numbers
        download_dir: the directory where the downloaded SRA files should be saved 

    returns:
        "Done" to represent the completeness of the processing         
        
    '''
    if not os.path.exists(download_dir):
        os.makedirs(download_dir)
        
    
    os.chdir(download_dir)
    
    if sra_list.endswith('.txt'):
        prefetch_cmd = "prefetch --option-file " + sra_list
        os.system(prefetch_cmd)

    else: 
        prefetch_cmd = "prefetch " + sra_list
        os.system(prefetch_cmd)

    return "sra files successfully downloaded"


# the prefetch may be encrypted,somtimes work while sometimes not, so not conducted for the unit test



def sra_to_fastq(sra_dir, rm_sra = False, paired = True):
    '''
    transform the sra files into FASTQ files, 
     delete original sra files to save the space based on choice
   
    Args:
        sra_dir: the path where the sra files are in
    Returns:
        fastq files for the corresponding sra files
        
    '''

    if not os.path.exists(sra_dir):
        return 'the input SRA path did not exist'

    else:
        files = os.listdir(sra_dir)
        if len(files) == 0:
            raise 'there is no sra file in the directory'

        else:
            #change to the directory 
            os.chdir(sra_dir)
            sra_files = [sra_f for sra_f in files if sra_f.startswith('SRR')]

            if paired:
                for file in sra_files:
                    fastq_dump_cmd_paired = 'fastq-dump --split-3 --gzip ' + sra_dir + '/' + file + '/' + file + '.sra'
                    #os.system(fastq_dump_cmd_paired)

                    #perform the fastqc html generation 
                    print("generated fastq file for " + file)

                    if rm_sra == True:
                        os.remove(sra_dir+'/'+file)
                        print(file + " removed")

        
            if not paired: 
                #if single end 
                for file in sra_files:
                    fastq_dump_cmd_single = 'fastq-dump --gzip ' + sra_dir + '/' + file + '/' + file + '.sra'
                    #os.system(fastq_dump_cmd_single)


                    print("generated fastq file for " + file)

            
                    if rm_sra == True:
                        os.remove(sra_dir+'/'+file)
                        print(file + " removed")

                     
    return 'sra file to fastq file completed'

#sra_to_fastq(sra_dir='/Users/jesi/Documents/BIOINFO_576/project_bioinfo576/SRA_download',paired = False)

    


# def fastqc_report(fastq_file_surfix,fastqc_dir):
#     '''
#     generate fastqc_html report for fastqc files

#     Args: 
#     fastq_file_surfix : the fastq_file surfix 
#     fastqc_dir : the directory save the fastqc report 
#     paired: the sequencing is paired end or single end 
#     '''
#     if not os.path.exists(fastqc_dir):
#         os.makedirs(fastqc_dir,mode=0o777, exist_ok=False)
#         #raise AttributeError('no fastqc directory found')
    
#     fastqc_cmd_single = 'fastqc '  + fastq_file_surfix + '.fastq.gz'
#     print(fastqc_cmd_single)
#     os.system(fastqc_cmd_single)
#     shutil.move(fastq_file_surfix+'_fastqc.html',fastqc_dir)
#     shutil.move(fastq_file_surfix+'_fastqc.gzip')

#     return "generating the fastqc report"