report 50102 Beta
{
    ApplicationArea = All;
    Caption = 'Beta';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/layout/Beta.rdl';

    dataset
    {
        dataitem(Parent; Integer)
        {
            DataItemTableView = where(Number = const(1));

            column(PerPage; PerPage) { }
            column(Parent_Number; Number) { }

            dataitem(Child; Integer)
            {
                DataItemTableView = where(Number = filter(1 .. 6));

                column(Child_Number; Number) { }

                trigger OnAfterGetRecord()
                begin
                    #region codeunit
                    CU_Rows += 1;
                    #endregion codeunit
                end;
            }

            dataitem(Blank; Integer)
            {
                column(Blank_Number; Number) { }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, Mathx.Modulo(-CU_Rows, PerPage));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                #region codeunit
                CU_Rows := 0;
                #endregion codeunit
            end;
        }
    }

    trigger OnInitReport()
    begin
        #region codeunit
        CU_Rows := 0;
        #endregion codeunit
        PerPage := 5;
    end;

    var
        Mathx: Codeunit Mathx;
        #region codeunit
        CU_Rows: Integer;
        #endregion codeunit
        PerPage: Integer;
}