package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.habbo.ui.widget.contextmenu.ButtonMenuView;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   import com.sulake.room.object.IRoomObject;
   
   public class FurnitureContextInfoView extends ButtonMenuView
   {
      
      protected var var_612:IRoomObject;
      
      protected var var_839:String;
      
      public function FurnitureContextInfoView(param1:class_1853)
      {
         super(param1);
      }
      
      public static function setup(param1:FurnitureContextInfoView, param2:IRoomObject, param3:String = "") : void
      {
         param1.var_612 = param2;
         param1.var_839 = param3;
         setupContext(param1);
      }
      
      protected function get roomObject() : IRoomObject
      {
         return var_612;
      }
      
      override public function dispose() : void
      {
         var_612 = null;
         super.dispose();
      }
   }
}

