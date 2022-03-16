#=========================================================================
# FILE NAME: xmlvalidate.pl
# AUTHOR   : Keith Hollifield
# DATE	   : 12/31/2022
#--------------------------------------------------------------------------
# REFERENCES: 
# https://stackoverflow.com/questions/1719139/why-does-my-xsd-file-fail-to-parse-with-xmllibxml
#
#==========================================================================

use strict; use warnings;

use XML::LibXML;
use XML::DOM;

my $xmldir='C:\dev\ISO20022\SampleMessages\SampleMessages';
my $xsddir='C:\dev\ISO20022\SampleMessages\SampleMessages';

# %testdata{'AppHdr.xml'}  = 'head.001.001.02.xsd';
# %testdata{'BckpPmt.xml'} = '*.xsd';
# %testdata{'CretStgOrdr.xml'} = '*.xsd';
# %testdata{'CstmrCdtTrfInitn.xml'} = '*.xsd';
# %testdata{'CstmrDrctDbtInitn.xml'} = '*.xsd'; 
# %testdata{'CstmrPmtRvsl.xml'} = '*.xsd';
# %testdata{'CstmrPmtStsRpt.xml'} = '*.xsd';
# %testdata{'GetAcct.xml'} = '*.xsd';
# %testdata{'GetbizDayInf.xml'} = '*.xsd';
# %testdata{'GetCcyXchgRate.xml'} = '*.xsd';
# %testdata{'GetTx.xml'} = '*.xsd';
# %testdata{'LqdtyCdtTrf.xml'} = '*.xsd';
# %testdata{'LqdtyDbtTrf.xml'} = '*.xsd';
# %testdata{'RtrAcct.xml'} = '*.xsd';
# %testdata{'RtrBizDayInf.xml'} = '*.xsd';
# %testdata{'RtrCcyXchgRate.xml'} = '*.xsd';
# %testdata{'RtrTx.xml'} = '*.xsd';

my $xml = 'AppHdr.xml';
my $xsd = 'head.001.001.02.xsd';

if ( my $error = validate_xml_against_xsd($xml, $xsd) ) {
    die "Validation failed: $error\n";
}

sub validate_xml_against_xsd {
    my ($xml, $xsd) = @_;

    my $schema = XML::LibXML::Schema->new(location => $xsd);
    my $parser = XML::LibXML->new;

    my $doc = $parser->parse_file($xml);
    eval { $schema->validate( $doc ) };

    if ( my $ex = $@ ) {
        return $ex;
    }
    return;
	
}

