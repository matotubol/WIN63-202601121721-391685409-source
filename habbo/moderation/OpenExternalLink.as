package com.sulake.habbo.moderation
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class OpenExternalLink
   {
      
      private var var_989:String;
      
      public function OpenExternalLink(param1:ModerationManager, param2:class_1741, param3:String)
      {
         super();
         param2.procedure = onClick;
         var_989 = param3;
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         navigateToURL(new URLRequest(var_989),"_blank");
      }
   }
}

