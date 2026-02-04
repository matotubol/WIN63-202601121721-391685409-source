package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class HtmlTextParam extends TextParam
   {
      
      private var var_4776:Boolean;
      
      public function HtmlTextParam(param1:int, param2:Boolean = false, param3:int = 0)
      {
         super(param1,false,param3);
         var_4776 = param2;
      }
      
      public function get selectable() : Boolean
      {
         return var_4776;
      }
   }
}

