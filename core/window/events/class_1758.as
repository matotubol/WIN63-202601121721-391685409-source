package com.sulake.core.window.events
{
   import com.sulake.core.window.class_1741;
   
   public class class_1758
   {
      
      public static const const_608:String = "WE_DESTROY";
      
      public static const const_294:String = "WE_DESTROYED";
      
      public static const const_268:String = "WE_OPEN";
      
      public static const const_853:String = "WE_OPENED";
      
      public static const const_179:String = "WE_CLOSE";
      
      public static const const_971:String = "WE_CLOSED";
      
      public static const WINDOW_EVENT_FOCUS:String = "WE_FOCUS";
      
      public static const const_762:String = "WE_FOCUSED";
      
      public static const WINDOW_EVENT_UNFOCUS:String = "WE_UNFOCUS";
      
      public static const const_1191:String = "WE_UNFOCUSED";
      
      public static const const_302:String = "WE_ACTIVATE";
      
      public static const const_814:String = "WE_ACTIVATED";
      
      public static const const_863:String = "WE_DEACTIVATE";
      
      public static const const_357:String = "WE_DEACTIVATED";
      
      public static const const_346:String = "WE_SELECT";
      
      public static const const_1042:String = "WE_SELECTED";
      
      public static const const_803:String = "WE_UNSELECT";
      
      public static const const_1011:String = "WE_UNSELECTED";
      
      public static const WINDOW_EVENT_LOCK:String = "WE_LOCK";
      
      public static const const_631:String = "WE_LOCKED";
      
      public static const WINDOW_EVENT_UNLOCK:String = "WE_UNLOCK";
      
      public static const const_1030:String = "WE_UNLOCKED";
      
      public static const const_401:String = "WE_ENABLE";
      
      public static const const_756:String = "WE_ENABLED";
      
      public static const const_1037:String = "WE_DISABLE";
      
      public static const const_1135:String = "WE_DISABLED";
      
      public static const const_1239:String = "WE_RELOCATE";
      
      public static const const_319:String = "WE_RELOCATED";
      
      public static const const_991:String = "WE_RESIZE";
      
      public static const const_779:String = "WE_RESIZED";
      
      public static const const_227:String = "WE_MINIMIZE";
      
      public static const const_939:String = "WE_MINIMIZED";
      
      public static const const_410:String = "WE_MAXIMIZE";
      
      public static const const_586:String = "WE_MAXIMIZED";
      
      public static const WINDOW_EVENT_RESTORE:String = "WE_RESTORE";
      
      public static const const_249:String = "WE_RESTORED";
      
      public static const const_1188:String = "WE_EXPANDED";
      
      public static const const_262:String = "WE_COLLAPSE";
      
      public static const const_1120:String = "WE_CHILD_ADDED";
      
      public static const const_771:String = "WE_CHILD_REMOVED";
      
      public static const const_666:String = "WE_CHILD_RELOCATED";
      
      public static const const_1032:String = "WE_CHILD_RESIZED";
      
      public static const const_173:String = "WE_CHILD_ACTIVATED";
      
      public static const const_282:String = "WE_CHILD_VISIBILITY";
      
      public static const const_328:String = "WE_PARENT_ADDED";
      
      public static const const_1118:String = "WE_PARENT_REMOVED";
      
      public static const const_1115:String = "WE_PARENT_RELOCATED";
      
      public static const const_432:String = "WE_PARENT_RESIZED";
      
      public static const const_1207:String = "WE_PARENT_ACTIVATED";
      
      public static const const_808:String = "WE_OK";
      
      public static const const_525:String = "WE_CANCEL";
      
      public static const WINDOW_EVENT_CHANGE:String = "WE_CHANGE";
      
      public static const const_461:String = "WE_SCROLL";
      
      public static const UNKNOWN:String = "";
      
      private static const const_17:Array = [];
      
      protected var var_230:String;
      
      protected var _window:class_1741;
      
      protected var var_1436:class_1741;
      
      protected var var_1166:Boolean;
      
      protected var var_943:Boolean;
      
      protected var var_123:Boolean;
      
      protected var var_1570:Array;
      
      public function class_1758()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:class_1741, param3:class_1741, param4:Boolean = false) : class_1758
      {
         var _loc5_:class_1758 = const_17.length > 0 ? const_17.pop() : new class_1758();
         _loc5_.var_230 = param1;
         _loc5_._window = param2;
         _loc5_.var_1436 = param3;
         _loc5_.var_943 = param4;
         _loc5_.var_123 = false;
         _loc5_.var_1570 = const_17;
         return _loc5_;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get target() : class_1741
      {
         return _window;
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
      
      public function get related() : class_1741
      {
         return var_1436;
      }
      
      public function get cancelable() : Boolean
      {
         return var_943;
      }
      
      public function recycle() : void
      {
         if(var_123)
         {
            throw new Error("Event already recycled!");
         }
         _window = var_1436 = null;
         var_123 = true;
         var_1166 = false;
         var_1570.push(this);
      }
      
      public function clone() : class_1758
      {
         return allocate(var_230,window,related,cancelable);
      }
      
      public function preventDefault() : void
      {
         preventWindowOperation();
      }
      
      public function isDefaultPrevented() : Boolean
      {
         return var_1166;
      }
      
      public function preventWindowOperation() : void
      {
         if(cancelable)
         {
            var_1166 = true;
            return;
         }
         throw new Error("Attempted to prevent window operation that is not cancelable!");
      }
      
      public function isWindowOperationPrevented() : Boolean
      {
         return var_1166;
      }
      
      public function stopPropagation() : void
      {
         var_1166 = true;
      }
      
      public function stopImmediatePropagation() : void
      {
         var_1166 = true;
      }
      
      public function toString() : String
      {
         return "WindowEvent { type: " + var_230 + " cancelable: " + var_943 + " window: " + _window + " }";
      }
   }
}

