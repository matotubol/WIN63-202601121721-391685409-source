package com.sulake.habbo.avatar
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import flash.events.IEventDispatcher;
   
   public interface class_141 extends IUnknown
   {
      
      function openEditor(param1:uint, param2:class_2071, param3:Array = null, param4:Boolean = false, param5:String = null, param6:String = "generic") : class_2250;
      
      function embedEditorToContext(param1:uint, param2:class_1812, param3:class_2071 = null, param4:Array = null, param5:Boolean = false, param6:Boolean = false) : Boolean;
      
      function loadAvatarInEditor(param1:uint, param2:String, param3:String, param4:int = 0) : void;
      
      function loadOwnAvatarInEditor(param1:uint) : void;
      
      function get events() : IEventDispatcher;
      
      function close(param1:uint) : void;
   }
}

