<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemMaster.aspx.cs" MasterPageFile="~/MenuMaster.Master" Inherits="DailyReport.ItemMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 
 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .card {
    font-size: 1em;
    overflow: hidden;
    padding: 0;
    border: none;
    border-radius: .28571429rem;
    box-shadow: 0 1px 3px 0 #d4d4d5, 0 0 0 1px #d4d4d5;
}

.card-block {
    font-size: 1em;
    position: relative;
    margin: 0;
    padding: 1em;
    border: none;
    border-top: 1px solid rgba(34, 36, 38, .1);
    box-shadow: none;
}
    </style>
    <script>
        $(document).ready(function () {

            $('.numberonly').keypress(function (e) {

                var charCode = (e.which) ? e.which : event.keyCode

                if (String.fromCharCode(charCode).match(/[^0-9]/g))

                    return false;

            });
        }

           
        );

        function validate() {
            if ($("#<%=txtitem.ClientID %>").val() == "") {
                alert("Please enter item");
                return false;
            }
            if ($("#<%=txtrate.ClientID %>").val() == "") {
                alert("Please enter Rate");
                 return false;
             }
         }
    </script>
    <div class="card col">
        <div class="card-header">
            Item Master
        </div>
        <div class="card-body">

            <div class="row mt-3 item-row">
                <div class="col-lg-4">
                    <asp:HiddenField id="hdnid" Value="0" runat="server" />
                    <asp:Label runat="server" ID="lblArea" Text="Item"></asp:Label>
                    <asp:TextBox CssClass="form-control" ID="txtitem" runat="server"></asp:TextBox>
                </div>   
                <div class="col-lg-8">
                    <asp:Label runat="server" ID="lbldesc" Text="Description"></asp:Label>
                    <asp:TextBox CssClass="form-control" ID="txtdesc" runat="server"></asp:TextBox>
                </div>
            </div>



            <div class="row item-row">
                <div class="col-sm-3">
                    <asp:Label runat="server" ID="lblrate" Text="Rate"></asp:Label>
                    <asp:TextBox CssClass="form-control numberonly" ID="txtrate" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-3">
                    <asp:Label runat="server" ID="lbldiscount" Text="Discount"></asp:Label>
                    <asp:TextBox CssClass="form-control numberonly" ID="txtDiscount" Text="0" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-3">
                    <asp:Label runat="server" ID="lblstock" Text="Stock"></asp:Label>
                    <asp:TextBox CssClass="form-control numberonly" ID="txtstocck" runat="server"></asp:TextBox>
                </div>

                <div class="col-sm-3">
                    <br />
                    <asp:Button ID="btnsave" type="submit" style="width:inherit" OnClientClick="return validate();" class="btn savebtn" runat="server" OnClick="btnsave_Click" Text="Save" />       
                    <asp:Label ID="lblerror" runat="server" ForeColor="Red"> </asp:Label>
                </div>
            </div>
         
          

            <div class="row item-row">

            
                <div class="col-lg-8">
                <asp:TextBox ID="txtsearch" runat="server" placeholder="Search Item" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtsearch_TextChanged"></asp:TextBox>
                   </div>

            <div class="col-lg-4">
                <asp:Button ID="btnExport" style="width: inherit" type="submit"  class="exportbtn btn" runat="server" OnClick="btnExport_Click" Text="Export to Excel" />
            </div>
                <br />
            </div>


                <asp:GridView CssClass="table table-responsive" ID="grdarea" runat="server" AutoGenerateColumns="false" HeaderStyle-BackColor="#dc3545"  OnSelectedIndexChanged="grdarea_SelectedIndexChanged">
                      <Columns>
                             <asp:BoundField DataField="Id" HeaderText="Id" />
                           <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                           <asp:BoundField DataField="Description" HeaderText="Description" />
                           <asp:BoundField DataField="Rate" HeaderText="Rate" />
                           <asp:BoundField DataField="Stock" HeaderText="Stock" />
                           <asp:BoundField DataField="IsActive" HeaderText="IsActive" />

                          <asp:TemplateField>

                              <ItemTemplate>
                                  <asp:button CssClass="btn btn-success"  ID="lnkupdate" runat="server" Text="Edit" CommandName="Select"  ></asp:button>
                              </ItemTemplate>

                          </asp:TemplateField>

                          </Columns>
                </asp:GridView>

   
            



        </div>
    </div>


</asp:Content>
