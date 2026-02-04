package com.sulake.habbo.session.events
{
   public class SessionDataToWidgetEvent extends SessionDataEvent
   {
      
      public static const const_175:String = "SDTWE_PURCHASABLE_STYLES_UPDATED";
      
      public function SessionDataToWidgetEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

