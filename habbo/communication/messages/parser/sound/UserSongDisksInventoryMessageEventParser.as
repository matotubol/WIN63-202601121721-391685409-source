package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class UserSongDisksInventoryMessageEventParser implements IMessageParser
   {
      
      private var var_711:class_55;
      
      public function UserSongDisksInventoryMessageEventParser()
      {
         super();
         var_711 = new class_55();
      }
      
      public function get songDiskCount() : int
      {
         return var_711.length;
      }
      
      public function getDiskId(param1:int) : int
      {
         if(param1 >= 0 && param1 < var_711.length)
         {
            return var_711.getKey(param1);
         }
         return -1;
      }
      
      public function getSongId(param1:int) : int
      {
         if(param1 >= 0 && param1 < var_711.length)
         {
            return var_711.getWithIndex(param1);
         }
         return -1;
      }
      
      public function flush() : Boolean
      {
         var_711.reset();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            var_711.add(_loc4_,_loc5_);
            _loc3_++;
         }
         return true;
      }
   }
}

