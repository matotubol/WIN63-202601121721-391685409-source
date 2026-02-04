package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.class_13;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class GenericEventQueue implements IEventQueue, class_13
   {
      
      protected var _disposed:Boolean = false;
      
      protected var var_450:IEventDispatcher;
      
      protected var _eventArray:Vector.<Event>;
      
      protected var _index:uint = 0;
      
      protected var var_2730:Boolean = true;
      
      public function GenericEventQueue(param1:IEventDispatcher)
      {
         super();
         _eventArray = new Vector.<Event>();
         var_450 = param1;
      }
      
      public function get length() : uint
      {
         return _eventArray.length;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_450 = null;
            if(_eventArray.length)
            {
               _eventArray.splice(0,_eventArray.length);
            }
            _disposed = true;
         }
      }
      
      public function begin() : void
      {
         if(!var_2730)
         {
            flush();
         }
         _index = 0;
         var_2730 = false;
      }
      
      public function next() : Event
      {
         var _loc1_:Event = null;
         if(_index < _eventArray.length)
         {
            _loc1_ = _eventArray[_index];
            _index = _index + 1;
         }
         return _loc1_;
      }
      
      public function remove() : void
      {
         _eventArray.splice(_index - 1,1);
         if(_index > 0)
         {
            _index = _index - 1;
         }
      }
      
      public function end() : void
      {
         _index = 0;
         var_2730 = true;
      }
      
      public function flush() : void
      {
         _eventArray.splice(0,_eventArray.length);
         _index = 0;
      }
      
      protected function eventListener(param1:Event) : void
      {
         _eventArray.push(param1);
      }
   }
}

