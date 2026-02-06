package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class class_2305
   {
      
      private var _name:String;
      
      private var var_202:int;
      
      private var var_2764:class_55;
      
      public function class_2305(param1:String, param2:int)
      {
         super();
         _name = param1;
         var_202 = param2;
         var_2764 = new class_55();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get target() : int
      {
         return var_202;
      }
      
      public function get queueTypes() : Array
      {
         return var_2764.getKeys();
      }
      
      public function getQueueSize(param1:String) : int
      {
         return var_2764.getValue(param1);
      }
      
      public function addQueue(param1:String, param2:int) : void
      {
         var_2764.add(param1,param2);
      }
   }
}

