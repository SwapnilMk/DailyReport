<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MenuMaster.Master" CodeBehind="Entry.aspx.cs" Inherits="DailyReport.Entry"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
      <div class="card col">
  <div class="card-header">
   Customer
  </div>
  <div class="card-body">
           

                 <div class="form-group">
                 
                       
                   <asp:Label ID="lblArea" runat="server" Text="Area"  ></asp:Label>
                   
                        <asp:DropDownList placeholder="Area" CssClass="form-control" ID="ddlArea" runat="server" ></asp:DropDownList>
                  

                </div>
               
                 <div class="form-group">
                    
                      
                 
                        <asp:TextBox class="form-control" placeholder="Customer Name" ID="txtCustomername" runat="server"></asp:TextBox>
                  

                </div>

                
                 <div class="form-group">

                  
                      
                 
                        <asp:TextBox placeholder="Address" class="form-control" ID="txtaddress" TextMode="MultiLine" runat="server"></asp:TextBox>
                   
                </div>
               
                <div class="form-group">

                
                        <asp:TextBox placeholder="Contact" class="form-control" ID="txtContact" TextMode="Number" runat="server"></asp:TextBox>
                  
                </div>

       <div id="divrate" runat="server" class="form-group">

                 
                        <asp:TextBox placeholder="Rate" class="form-control" ID="txtrate" TextMode="Number" runat="server"></asp:TextBox>
           
                </div>
             

                   <div class="form-group">

                   
                        <asp:Label runat="server" ID="Label1" Text=""></asp:Label>
                    
                   
                        <asp:Button CssClass="btn btn-danger col-sm-3"  ID="btnsave" Text="Save" runat="server" OnClick="btnsave_Click" />
                          <asp:Label ID="lblerror" runat="server" ForeColor="Red" ></asp:Label>

                </div>

               <div class="form-group">
                    <asp:GridView CssClass="table table-bordered table-responsive" HeaderStyle-BackColor="Red" ID="grdcustomer" runat="server" AutoGenerateColumns="true">
                        <Columns>

                        </Columns>
                    </asp:GridView>
                </div>
            </div>
      </div>
</asp:Content>  