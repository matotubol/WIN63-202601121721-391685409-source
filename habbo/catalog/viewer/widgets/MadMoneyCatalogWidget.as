package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   
   public class MadMoneyCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var var_1812:class_1775;
      
      public function MadMoneyCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_1812 != null)
         {
            var_1812.removeEventListener("WME_CLICK",eventProc);
            var_1812 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_1812 = _window.findChildByName("ctlg_madmoney_button") as class_1775;
         if(var_1812 != null)
         {
         }
         return true;
      }
      
      private function eventProc(param1:WindowMouseEvent) : void
      {
         var event:WindowMouseEvent = param1;
         page.viewer.catalog.windowManager.alert("TODO","Fix in MadMoneyCatalogWidget.as",0,function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         });
      }
   }
}

