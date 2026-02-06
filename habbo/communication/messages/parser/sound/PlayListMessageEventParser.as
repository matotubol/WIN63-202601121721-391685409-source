package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.class_3136;
   
   [SecureSWF(rename="true")]
   public class PlayListMessageEventParser implements IMessageParser
   {
      
      private var var_2745:int;
      
      private var var_3450:Array;
      
      public function PlayListMessageEventParser()
      {
         super();
      }
      
      public function get synchronizationCount() : int
      {
         return var_2745;
      }
      
      public function get playList() : Array
      {
         return var_3450;
      }
      
      public function flush() : Boolean
      {
         var_2745 = -1;
         var_3450 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2745 = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         var _loc6_:int = 0;
         while(0 < _loc3_)
         {
            var _loc7_:int = param1.readInteger();
            var _loc4_:int = param1.readInteger();
            var _loc5_:String = param1.readString();
            var _loc2_:String = param1.readString();
            var_3450.push(new class_3136(0,0,null,null));
            _loc6_++;
         }
         return true;
      }
   }
}

