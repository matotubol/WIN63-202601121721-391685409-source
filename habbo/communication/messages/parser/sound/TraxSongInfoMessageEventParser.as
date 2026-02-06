package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.class_3637;
   
   [SecureSWF(rename="true")]
   public class TraxSongInfoMessageEventParser implements IMessageParser
   {
      
      private var var_3710:Array;
      
      public function TraxSongInfoMessageEventParser()
      {
         super();
      }
      
      public function get songs() : Array
      {
         return var_3710;
      }
      
      public function flush() : Boolean
      {
         var_3710 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc9_:int = 0;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc8_:int = 0;
         var _loc10_:class_3637 = null;
         var _loc5_:int = param1.readInteger();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc9_ = param1.readInteger();
            _loc4_ = param1.readString();
            _loc6_ = param1.readString();
            _loc2_ = param1.readString();
            _loc7_ = param1.readInteger();
            _loc3_ = param1.readString();
            _loc10_ = new class_3637(_loc9_,_loc7_,_loc6_,_loc3_,_loc2_);
            var_3710.push(_loc10_);
            _loc8_++;
         }
         return true;
      }
   }
}

