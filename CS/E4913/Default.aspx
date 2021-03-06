﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="E4913.Default" %>

<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.1, Version=13.1.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxImageSlider" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        var isPlayed = false;
        var timer;

        function GetTimeout(itemName) {
            var defaultTimeout = 1000;
            return hiddenField.Contains(itemName) ? hiddenField.Get(itemName) : defaultTimeout;
        }

        function Play() {
            if (!isPlayed) {
                var item = imageSlider.GetActiveItem(); 
                               
                timer = setTimeout(function () {
                    var nextItemIndex = (item.index + 1) % imageSlider.GetItemCount();
                    imageSlider.SetActiveItemIndex(nextItemIndex);
                }, GetTimeout(item.name));

                isPlayed = true;
            }
        }

        function Pause() {
            if (isPlayed) {
                clearTimeout(timer);
                isPlayed = false;
            }
        }

        function ItemChanged() {
            if (isPlayed) {
                clearTimeout(timer);
                isPlayed = false;
                Play();
            }
        }




        // Handlers

        function imageSlider_Init(s, e) {
            Play();
        }

        function imageSlider_ActiveItemChanged(s, e) {
            ItemChanged();
        }

        function btPlay_Click(s, e) {
            if (isPlayed) {
                Pause();
                s.SetText("Play");
            }
            else {
                Play();
                s.SetText("Pause");
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxHiddenField ID="hfCustomIntervals" runat="server" ClientInstanceName="hiddenField"
            OnInit="hfCustomIntervals_Init">
        </dx:ASPxHiddenField>
        <dx:ASPxButton ID="btPlay" runat="server" Text="Pause" AutoPostBack="false">
            <ClientSideEvents Click="btPlay_Click" />
        </dx:ASPxButton>
        <dx:ASPxImageSlider ID="imageSlider" runat="server" ClientInstanceName="imageSlider" Width="600px">
            <ClientSideEvents Init="imageSlider_Init" ActiveItemChanged="imageSlider_ActiveItemChanged" />
            <SettingsImageArea ItemTextVisibility="Always" 
                NavigationButtonVisibility="None" />
            <SettingsNavigationBar Mode="Dots" />
            <Items>
                <dx:ImageSliderItem ImageUrl="~/Images/cherries.jpg" Name="Cherries" Text="Cherries (Timeout: 2 sec)">
                </dx:ImageSliderItem>
                <dx:ImageSliderItem ImageUrl="~/Images/raspberry.jpg" Name="Raspberry" Text="Raspberry (Timeout: 5 sec)">
                </dx:ImageSliderItem>
                <dx:ImageSliderItem ImageUrl="~/Images/strawberry.jpg" Name="Strawberry" Text="Strawberry (Timeout: 1 sec)">
                </dx:ImageSliderItem>
                <dx:ImageSliderItem ImageUrl="~/Images/tomatoes.jpg" Name="Tomatoes" Text="Tomatoes (Timeout: 4 sec)">
                </dx:ImageSliderItem>
            </Items>
        </dx:ASPxImageSlider>
    </div>
    </form>
</body>
</html>
