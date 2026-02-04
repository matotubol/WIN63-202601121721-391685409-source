package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetApproveNameResultEvent extends Event
   {
      
      private var var_1122:int;
      
      private var _nameValidationInfo:String;
      
      public function CatalogWidgetApproveNameResultEvent(param1:int, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super("CWE_APPROVE_RESULT",param3,param4);
         var_1122 = param1;
         _nameValidationInfo = param2;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function get nameValidationInfo() : String
      {
         return _nameValidationInfo;
      }
   }
}

