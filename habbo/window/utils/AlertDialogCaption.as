package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.utils.class_2675;
   
   public class AlertDialogCaption implements class_2675
   {
      
      private var _text:String;
      
      private var var_3153:String;
      
      private var var_588:Boolean;
      
      public function AlertDialogCaption(param1:String, param2:String, param3:Boolean)
      {
         super();
         _text = param1;
         var_3153 = param2;
         var_588 = param3;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function get toolTip() : String
      {
         return var_3153;
      }
      
      public function set toolTip(param1:String) : void
      {
         var_3153 = param1;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
      
      public function set visible(param1:Boolean) : void
      {
         var_588 = param1;
      }
   }
}

