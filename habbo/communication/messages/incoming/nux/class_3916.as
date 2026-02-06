package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3916
   {
      
      private var var_3618:Vector.<class_3961>;
      
      private var var_2245:String;
      
      public function class_3916(param1:IMessageDataWrapper)
      {
         super();
         var_2245 = param1.readString();
         if(var_2245 == "")
         {
            var_2245 = null;
         }
         var_3618 = new Vector.<class_3961>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3618.push(new class_3961(param1));
            _loc3_++;
         }
      }
      
      public function get productOfferList() : Vector.<class_3961>
      {
         return var_3618;
      }
      
      public function get thumbnailUrl() : String
      {
         return var_2245;
      }
   }
}

