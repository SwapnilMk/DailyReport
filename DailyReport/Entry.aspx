<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MenuMaster.Master" CodeBehind="Entry.aspx.cs" Inherits="DailyReport.Entry"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
      <div class="card col">
  <div class="card-header">
   Customer
  </div>
  <div class="card-body">
           

                 <div class="row form-group customer-row">

                 <div class="col">     
                   <asp:Label ID="lblArea" runat="server" Text="Area"  ></asp:Label>
                   <asp:DropDownList placeholder="Area" CssClass="form-control" ID="ddlArea" runat="server" ></asp:DropDownList>
                </div>
                </div>
               
                 <div class="row form-group customer-row">
                 <div class="col-lg-6">
                       <asp:Label ID="lblcustomername" runat="server" Text="Customer Name"></asp:Label>
                        <asp:TextBox class="form-control" placeholder="Customer Name" ID="txtCustomername" runat="server"></asp:TextBox>
                </div>

                
                 <div class="col-lg-6">
                       <asp:Label ID="lbladdress" runat="server" Text="Customer Address"></asp:Label>
                        <asp:TextBox placeholder="Address" class="form-control" ID="txtaddress" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                </div>
               
                <div class="row form-group customer-row">
                <div class="col-lg-6">

                
                       <asp:Label ID="lblcontact" runat="server" Text="Phone Number"></asp:Label>
                        <asp:TextBox placeholder="Contact" class="form-control" ID="txtContact" TextMode="Number" runat="server"></asp:TextBox>
                  
                </div>
                   <div class="col-lg-6">
                       <br />
                   
                        <asp:Label runat="server" ID="Label1" Text=""></asp:Label>
                    
                   
                        <asp:Button CssClass="btn btn-danger col-lg-6" style="width: inherit;"  ID="btnsave" Text="Save" runat="server" OnClick="btnsave_Click" />
                          <asp:Label ID="lblerror" runat="server" ForeColor="Red" ></asp:Label>

       <div id="divrate" runat="server" class="form-group customer-row">

                 
                        <asp:TextBox placeholder="Rate" class="form-control" ID="txtrate" TextMode="Number" runat="server"></asp:TextBox>
                </div>
                </div>

           
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