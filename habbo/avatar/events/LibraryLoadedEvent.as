package com.sulake.habbo.avatar.events
{
   import flash.events.Event;
   
   public class LibraryLoadedEvent extends Event
   {
      
      private var _libName:String;
      
      public function LibraryLoadedEvent(param1:String, param2:String)
      {
         super(param1);
         this._libName = param2;
      }
      
      public function get library() : String
      {
         return _libName;
      }
   }
}

