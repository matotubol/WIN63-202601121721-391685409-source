package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3961
   {
      
      private var var_2711:String;
      
      private var _localizationKey:String;
      
      public function class_3961(param1:IMessageDataWrapper)
      {
         super();
         var_2711 = param1.readString();
         _localizationKey = param1.readString();
         if(_localizationKey == "")
         {
            _localizationKey = null;
         }
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get localizationKey() : String
      {
         return _localizationKey;
      }
   }
}

