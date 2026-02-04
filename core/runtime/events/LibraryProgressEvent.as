package com.sulake.core.runtime.events
{
   import flash.events.ProgressEvent;
   
   public class LibraryProgressEvent extends ProgressEvent
   {
      
      private var _elapsedTime:int = 0;
      
      private var _fileName:String = "";
      
      public function LibraryProgressEvent(param1:String, param2:uint = 0, param3:uint = 0, param4:int = 0)
      {
         _fileName = param1;
         _elapsedTime = param4;
         super("progress",false,false,param2,param3);
      }
      
      public function get elapsedTime() : int
      {
         return _elapsedTime;
      }
      
      public function get fileName() : String
      {
         return _fileName;
      }
   }
}

