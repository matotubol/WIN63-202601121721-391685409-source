package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.class_3136;
   
   [SecureSWF(rename="true")]
   public class PlayListSongAddedMessageEventParser implements IMessageParser
   {
      
      private var var_3010:class_3136;
      
      public function PlayListSongAddedMessageEventParser()
      {
         super();
      }
      
      public function get entry() : class_3136
      {
         return var_3010;
      }
      
      public function flush() : Boolean
      {
         var_3010 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc5_:int = param1.readInteger();
         var _loc4_:int = param1.readInteger();
         var _loc2_:String = param1.readString();
         var _loc3_:String = param1.readString();
         var_3010 = new class_3136(_loc5_,_loc4_,_loc2_,_loc3_);
         return true;
      }
   }
}

