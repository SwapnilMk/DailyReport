<%@ Page Title="" Language="C#" MasterPageFile="~/MenuMaster.Master" AutoEventWireup="true" CodeBehind="Saloon.aspx.cs" Inherits="DailyReport.Saloon" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link href="Select/select2.css" rel="stylesheet" type="text/css" />
    <script src="Select/select2.js"></script>

<script type="text/javascript">
    $(document).ready(function () {

         
        $('.numberonly').keypress(function (e) {

            var charCode = (e.which) ? e.which : event.keyCode

            if (String.fromCharCode(charCode).match(/[^0-9]/g))

                return false;

        });  

        $("#<%=ddlItem.ClientID%>").select2({
            placeholder: "Select an option",
            allowClear: true
        });

    });

    function validateitem() {
        if ($("[id*=grditem] td").closest("tr").length == 0) {
            alert("Please add item");
            return false;
        }

    }
    function ttl()
    {

        if ($("#<%=txtQty.ClientID %>").val() != "") {
            var discount = $("#<%=txtQty.ClientID %>").val() * $("#<%=hdndisc.ClientID %>").val();

            $("#<%=txtDiscount.ClientID %>").val(discount);
        }
        //alert(discount);
    }
    function Total()
    {
      

        if ($("#<%=txtQty.ClientID %>").val() == "")
        {
            alert("Please select Qty");
            return false;
        }
       else if ($("#<%=txtrate.ClientID %>").val() == "") {
            alert("Please select Rate");
            return false;
        }
        
      
    }
</script>
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
</asp:ScriptManager>


 

    <asp:UpdatePanel ID="up1" runat="server"> 
<ContentTemplate>
    <div class="card col d-flex justify-content-center" style="width:100%;">
  <div class="card-header text-black bg-danger">
   Daily Entry
  </div>

  <div class="card-body">
  
     
      <asp:HiddenField ID="hdndisc" runat="server" Value="0" />
         <div class="row">
            <div class="col-sm-2">
                <asp:Label  runat="server" ID="lblcustomer" Text="Customer"></asp:Label>

            </div>
            <div class="col-sm-3">
                <asp:TextBox CssClass="form-control" ID="txtcustomer" runat="server"></asp:TextBox>
                <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" ServiceMethod="SearchCustomers"
    MinimumPrefixLength="2" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
    TargetControlID="txtcustomer" FirstRowSelected="false">
</cc1:AutoCompleteExtender>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-2">
                <asp:Label  runat="server" ID="lblArea" Text="Item"></asp:Label>

            </div>
            <div class="col-sm-3">
               
                 <asp:DropDownList  CssClass="form-control"  AutoPostBack="true" OnSelectedIndexChanged="ddlItem_SelectedIndexChanged" ID="ddlItem" runat="server">
                                <asp:ListItem>
                                    select item
                                </asp:ListItem>
                            </asp:DropDownList>
       

            </div>
      
            <div class="col-sm-1">
                <asp:Label  runat="server" ID="lblrate" Text="Rate"></asp:Label>

            </div>
            <div class="col-sm-1">
                <asp:TextBox CssClass="form-control numberonly" ID="txtrate" runat="server"></asp:TextBox>
            </div>

                    <div class="col-sm-1">
                <asp:Label  runat="server" ID="lblqty" Text="Qty"></asp:Label>

            </div>
            <div class="col-sm-1">
                <asp:TextBox CssClass="form-control numberonly"   ID="txtQty" onchange="return ttl()" runat="server"></asp:TextBox>
            </div>
               <div class="col-sm-1">
                <asp:TextBox CssClass="form-control numberonly"   ID="txtDiscount" runat="server"></asp:TextBox>
            </div>
      
                <div class="col-sm-2">
                <asp:Button ID="btnadditem" OnClick="btnadditem_Click" OnClientClick="return Total()" runat="server" text="Add item"/>
            </div>
                 <div class="col-sm-6">
        <asp:GridView CssClass="table table-responsive" ID="grditem" runat="server" AutoGenerateColumns="false" OnRowDeleting="grditem_RowDeleting" DataKeyNames="id">
            <Columns>
             <asp:BoundField DataField="id" HeaderText="id" Visible="false" />
                <asp:BoundField DataField="ItemId" HeaderText="ItemId" Visible="false"  />
<asp:BoundField DataField="ItemName" HeaderText="Item Name" />
<asp:BoundField DataField="Qty" HeaderText="Qty" />
<asp:BoundField DataField="Rate" HeaderText="Rate" />
 <asp:BoundField DataField="Discont" HeaderText="Discount" />
                <asp:BoundField DataField="Total" HeaderText="Total" />






<asp:CommandField ShowDeleteButton="True" ButtonType="Button" />
            </Columns>
             
        </asp:GridView>
    </div>


        </div>
        <div class="row">
            <div class="col-sm-2">
                <asp:Label  runat="server" ID="lbldesc" Text="Description"></asp:Label>

            </div>
            <div class="col-sm-3">
                <asp:TextBox CssClass="form-control" ID="txtdesc" runat="server"></asp:TextBox>
            </div>
        </div>

      
      <div class="row">
            <div class="col-sm-2">
                <asp:Label  runat="server" ID="Label1" Text="Amount"></asp:Label>

            </div>
            <div class="col-sm-3">
                <asp:TextBox CssClass="form-control numberonly" ID="txtAmount" runat="server"></asp:TextBox>
            </div>

          <div class="col-sm-3">
         <asp:FileUpload ID="fileup1" runat="server" CssClass="form-control" />
            </div>
        </div>

      <br />
       <div class="row">
        <div class="col-sm-2">
                

            </div>
        <div class="col-sm-3">
       
               <asp:Button ID="btnsave" Width="200px"  CssClass=" btn btn-success" runat="server" Text="Save" OnClientClick="return validateitem()" OnClick="btnsave_Click" />
               
          
            <asp:Label ID="lblerror" runat="server" ForeColor="Red"> </asp:Label>
        </div>
</div>
    
    <br />
    <div>
        <asp:GridView CssClass="table table-responsive" ID="grdEntry" runat="server">
            

        </asp:GridView>
    </div>



  </div>
</div>
    
    </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnsave"/>
        </Triggers>
</asp:UpdatePanel>
    
</asp:Content>
