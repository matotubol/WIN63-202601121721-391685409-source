package com.sulake.core.window
{
   import com.sulake.core.window.components.*;
   import flash.utils.Dictionary;
   
   public class Classes
   {
      
      protected static var var_28:Dictionary;
      
      public function Classes()
      {
         super();
      }
      
      public static function init() : void
      {
         if(!var_28)
         {
            var_28 = new Dictionary();
            var_28[0] = WindowController;
            var_28[40] = ActivatorController;
            var_28[2] = BackgroundController;
            var_28[30] = BorderController;
            var_28[17] = BoxSizerController;
            var_28[45] = BubbleController;
            var_28[46] = WindowController;
            var_28[47] = WindowController;
            var_28[48] = WindowController;
            var_28[49] = WindowController;
            var_28[60] = ButtonController;
            var_28[61] = ButtonController;
            var_28[67] = SelectableButtonController;
            var_28[68] = SelectableButtonController;
            var_28[69] = SelectableButtonController;
            var_28[21] = BitmapWrapperController;
            var_28[70] = CheckBoxController;
            var_28[4] = ContainerController;
            var_28[41] = ContainerButtonController;
            var_28[72] = CloseButtonController;
            var_28[20] = DisplayObjectWrapperController;
            var_28[76] = ScrollBarLiftController;
            var_28[102] = DropMenuController;
            var_28[103] = DropMenuItemController;
            var_28[105] = DropListController;
            var_28[106] = DropListItemController;
            var_28[15] = FormattedTextController;
            var_28[35] = FrameController;
            var_28[6] = HeaderController;
            var_28[11] = HTMLTextController;
            var_28[1] = IconController;
            var_28[79] = IconButtonController;
            var_28[50] = ItemListController;
            var_28[51] = ItemListController;
            var_28[50] = ItemListController;
            var_28[52] = ItemGridController;
            var_28[54] = ItemGridController;
            var_28[53] = ItemGridController;
            var_28[12] = TextLabelController;
            var_28[14] = TextLinkController;
            var_28[78] = PasswordFieldController;
            var_28[71] = RadioButtonController;
            var_28[5] = RegionController;
            var_28[120] = ScalerController;
            var_28[130] = ScrollBarController;
            var_28[131] = ScrollBarController;
            var_28[139] = ButtonController;
            var_28[137] = ButtonController;
            var_28[138] = ButtonController;
            var_28[136] = ButtonController;
            var_28[132] = ScrollBarLiftController;
            var_28[133] = ScrollBarLiftController;
            var_28[134] = WindowController;
            var_28[135] = WindowController;
            var_28[56] = ScrollableItemListWindow;
            var_28[140] = ScrollableItemGridWindow;
            var_28[42] = SelectorController;
            var_28[43] = SelectorListController;
            var_28[23] = StaticBitmapWrapperController;
            var_28[93] = TabButtonController;
            var_28[94] = TabContainerButtonController;
            var_28[90] = ContainerController;
            var_28[91] = TabContextController;
            var_28[92] = SelectorListController;
            var_28[10] = TextController;
            var_28[77] = TextFieldController;
            var_28[8] = ToolTipController;
            var_28[16] = WidgetWindowController;
         }
      }
      
      public static function getWindowClassByType(param1:uint) : Class
      {
         return var_28[param1];
      }
   }
}

