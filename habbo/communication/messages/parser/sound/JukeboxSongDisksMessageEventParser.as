package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class JukeboxSongDisksMessageEventParser implements IMessageParser
   {
      
      private var var_3128:class_55;
      
      private var var_3176:int;
      
      public function JukeboxSongDisksMessageEventParser()
      {
         super();
         var_3128 = new class_55();
      }
      
      public function get songDisks() : class_55
      {
         return var_3128;
      }
      
      public function get maxLength() : int
      {
         return var_3176;
      }
      
      public function flush() : Boolean
      {
         var_3128.reset();
         var_3176 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3176 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            var_3128.add(_loc4_,_loc5_);
            _loc3_++;
         }
         return true;
      }
   }
}

