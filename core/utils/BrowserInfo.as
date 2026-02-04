package com.sulake.core.utils
{
   public class BrowserInfo
   {
      
      public static const const_591:String = "win";
      
      public static const MAC_PLATFORM:String = "mac";
      
      public static const SAFARI_AGENT:String = "safari";
      
      public static const const_504:String = "opera";
      
      public static const IE_AGENT:String = "msie";
      
      public static const MOZILLA_AGENT:String = "mozilla";
      
      public static const CHROME_AGENT:String = "chrome";
      
      private var var_5019:String = "undefined";
      
      private var var_4745:String = "undefined";
      
      private var var_4985:String = "undefined";
      
      public function BrowserInfo(param1:Object, param2:Object, param3:String)
      {
         super();
         if(!param1 || !param2 || !param3)
         {
            return;
         }
         var_4985 = param1.version;
         for(var _loc5_ in param1)
         {
            if(_loc5_ != "version")
            {
               if(param1[_loc5_] == true)
               {
                  var_4745 = _loc5_;
                  break;
               }
            }
         }
         for(var _loc4_ in param2)
         {
            if(param2[_loc4_] == true)
            {
               var_5019 = _loc4_;
            }
         }
      }
      
      public function get platform() : String
      {
         return var_5019;
      }
      
      public function get browser() : String
      {
         return var_4745;
      }
      
      public function get version() : String
      {
         return var_4985;
      }
   }
}

