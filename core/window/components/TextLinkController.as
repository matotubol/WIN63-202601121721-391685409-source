package com.sulake.core.window.components
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.theme.IThemeManager;
   import flash.geom.Rectangle;
   
   public class TextLinkController extends TextController implements ITextLinkWindow
   {
      
      private var var_2097:uint;
      
      private var var_807:String;
      
      private var var_2692:Boolean;
      
      protected var var_2905:Boolean;
      
      protected var var_1630:class_55;
      
      public function TextLinkController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc12_:IThemeManager = param5.getWindowFactory().getThemeManager();
         var_2097 = int(_loc12_.getPropertyDefaults(param3).method_20("tool_tip_delay").value);
         var_807 = String(_loc12_.getPropertyDefaults(param3).method_20("tool_tip_caption").value);
         var_2692 = _loc12_.getPropertyDefaults(param3).method_20("tool_tip_is_dynamic").value;
         var_2905 = _loc12_.getPropertyDefaults(param3).method_20("interactive_cursor_disabled").value;
         super(param1,param2,param3,(param4 | 1) & ~0x10,param5,param6,param7,param8,param9,param10,param11);
         immediateClickMode = true;
         mouseThreshold = 0;
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         if(param1 == this)
         {
            InteractiveController.processInteractiveWindowEvents(this,param2);
         }
         return _loc3_;
      }
      
      public function set mouseCursorType(param1:uint) : void
      {
      }
      
      public function get mouseCursorType() : uint
      {
         return 0;
      }
      
      public function set toolTipCaption(param1:String) : void
      {
         var_807 = param1 == null ? "" : param1;
      }
      
      public function get toolTipCaption() : String
      {
         return var_807;
      }
      
      public function set toolTipDelay(param1:uint) : void
      {
         var_2097 = param1;
      }
      
      public function get toolTipDelay() : uint
      {
         return var_2097;
      }
      
      public function setMouseCursorForState(param1:uint, param2:uint) : uint
      {
         if(!var_1630)
         {
            var_1630 = new class_55();
         }
         var _loc3_:uint = uint(var_1630[param1]);
         if(param2 == 0 || param2 == -1)
         {
            var_1630.remove(param1);
         }
         else
         {
            var_1630[param1] = param2;
         }
         return _loc3_;
      }
      
      public function getMouseCursorByState(param1:uint) : uint
      {
         if(!var_1630)
         {
            return 0;
         }
         return var_1630.getValue(param1);
      }
      
      public function showToolTip(param1:IToolTipWindow) : void
      {
         throw new Error("Unimplemented method!");
      }
      
      public function hideToolTip() : void
      {
         throw new Error("Unimplemented method!");
      }
      
      override public function get properties() : Array
      {
         return InteractiveController.writeInteractiveWindowProperties(this,super.properties);
      }
      
      override public function set properties(param1:Array) : void
      {
         InteractiveController.readInteractiveWindowProperties(this,param1);
         super.properties = param1;
      }
      
      public function set toolTipIsDynamic(param1:Boolean) : void
      {
         var_2692 = param1;
      }
      
      public function get toolTipIsDynamic() : Boolean
      {
         return var_2692;
      }
      
      public function get interactiveCursorDisabled() : Boolean
      {
         return var_2905;
      }
      
      public function set interactiveCursorDisabled(param1:Boolean) : void
      {
         var_2905 = param1;
      }
   }
}

