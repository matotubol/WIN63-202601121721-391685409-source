package com.sulake.room.events
{
   import flash.events.Event;
   
   public class RoomContentLoadedEvent extends Event
   {
      
      public static const CONTENT_LOAD_SUCCESS:String = "RCLE_SUCCESS";
      
      public static const CONTENT_LOAD_FAILURE:String = "RCLE_FAILURE";
      
      public static const CONTENT_LOAD_CANCEL:String = "RCLE_CANCEL";
      
      private var var_2763:String;
      
      public function RoomContentLoadedEvent(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         var_2763 = param2;
      }
      
      public function get contentType() : String
      {
         return var_2763;
      }
   }
}

