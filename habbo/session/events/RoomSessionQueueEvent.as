package com.sulake.habbo.session.events
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionQueueEvent extends RoomSessionEvent
   {
      
      public static const QUEUE_STATUS:String = "RSQE_QUEUE_STATUS";
      
      public static const const_1109:String = "c";
      
      public static const QUEUE_TYPE_NORMAL:String = "d";
      
      public static const const_579:int = 2;
      
      public static const const_515:int = 1;
      
      private var _name:String;
      
      private var var_202:int;
      
      private var var_2764:class_55;
      
      private var var_1037:Boolean;
      
      private var var_5380:String;
      
      public function RoomSessionQueueEvent(param1:IRoomSession, param2:String, param3:int, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSQE_QUEUE_STATUS",param1,param5,param6);
         _name = param2;
         var_202 = param3;
         var_2764 = new class_55();
         var_1037 = param4;
      }
      
      public function get isActive() : Boolean
      {
         return var_1037;
      }
      
      public function get queueSetName() : String
      {
         return _name;
      }
      
      public function get queueSetTarget() : int
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

