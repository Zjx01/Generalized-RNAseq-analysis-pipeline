#unitest for preprocessing function
from grnae import preprocessing as prepc
import pytest
import os 
from pathlib import Path

def test_sra_to_fastq():
    sra_dir = '/Users/jesi/Documents/BIOINFO_576/SRA_download'
    paired = False
    test_result = prepc.sra_to_fastq(sra_dir = sra_dir,paired = paired)
    expected = 'sra file to fastq file completed'
    assert test_result == expected, f'The sra is successfully converted to fastq'

def test_edge_case():
    #edge cases
    edge_sra_dir= '/path_unexist'
    paired = False
    edge_expected = 'the input SRA path did not exist'
    with pytest.raises(AttributeError):
        a = prepc.sra_to_fastq(sra_dir = edge_sra_dir,paired = paired)
        assert a.type is AttributeError


