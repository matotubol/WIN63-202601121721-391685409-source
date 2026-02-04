package com.sulake.room
{
   public interface IRoomManagerListener
   {
      
      function roomManagerInitialized(param1:Boolean) : void;
      
      function contentLoaded(param1:String, param2:Boolean) : void;
      
      function objectInitialized(param1:String, param2:int, param3:int) : void;
      
      function objectsInitialized(param1:String) : void;
   }
}

