report 50102 HTMLPort
{
    Caption = 'HTMLPort';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "Document Type", "No.";

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    outStream.WriteText('<div>' + "Sales Line"."No." + '</div>');
                end;
            }
        }
    }

    trigger OnPreReport()
    begin
        tempBlob.CreateOutStream(outStream);
    end;

    trigger OnPostReport()
    begin
        fileManagement.BLOBExport(tempBlob, 'test.html', true);
    end;

    var
        fileManagement: Codeunit "File Management";
        tempBlob: Codeunit "Temp Blob";
        inStream: InStream;
        outStream: OutStream;
}