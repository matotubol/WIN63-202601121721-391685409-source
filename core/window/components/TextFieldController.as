package com.sulake.core.window.components
{
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.TextEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TextFieldController extends TextController implements ITextFieldWindow
   {
      
      private static const _WORD_DELIMS:RegExp = /[~%&!\\;:"',<>?#\s\.\-()=\[\]\{\}\^_]/g;
      
      private var var_3251:DropShadowFilter = new DropShadowFilter(1,90,16777215,1,0,0);
      
      protected var var_2097:uint = 500;
      
      protected var var_807:String = "";
      
      protected var var_2692:Boolean = false;
      
      protected var var_2905:Boolean;
      
      protected var var_1792:Boolean = false;
      
      protected var var_2648:Boolean = true;
      
      protected var var_704:Boolean = false;
      
      protected var _filters:Array = [];
      
      protected var var_2018:Boolean;
      
      public function TextFieldController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 &= ~0x10;
         param4 = uint(param4 | 1);
         var_25 = param6.x;
         var_26 = param6.y;
         var_29 = param6.width;
         var_32 = param6.height;
         _field = TextField(getGraphicContext(true).getDisplayObject());
         _field.antiAliasType = "advanced";
         _field.gridFitType = "pixel";
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         _field.addEventListener("textInput",onTextInputEvent);
         _field.addEventListener("keyDown",onKeyDownEvent);
         _field.addEventListener("keyUp",onKeyUpEvent);
         _field.addEventListener("change",onChangeEvent);
         _field.addEventListener("focusIn",onFocusEvent);
         _field.addEventListener("focusOut",onFocusEvent);
         _field.addEventListener("removedFromStage",onRemovedEvent);
         antiAliasType = "advanced";
         gridFitType = "pixel";
         var_326 = false;
         var_704 = true;
      }
      
      public static function getWordPositions(param1:String) : Array
      {
         var _loc3_:Object = null;
         var _loc2_:Array = [];
         _loc2_.push(0);
         while(true)
         {
            _loc3_ = _WORD_DELIMS.exec(param1);
            if(_loc3_ == null)
            {
               break;
            }
            if(_loc3_.index < param1.length)
            {
               _loc2_.push(_loc3_.index + 1);
            }
         }
         return _loc2_;
      }
      
      public function get focused() : Boolean
      {
         if(_field)
         {
            if(_field.stage)
            {
               return _field.stage.focus == _field;
            }
         }
         return false;
      }
      
      override public function enable() : Boolean
      {
         if(super.enable())
         {
            _field.type = var_2648 ? "input" : "dynamic";
            return true;
         }
         _field.type = "dynamic";
         return false;
      }
      
      override public function disable() : Boolean
      {
         if(super.disable())
         {
            _field.type = "dynamic";
            return true;
         }
         _field.type = var_2648 ? "input" : "dynamic";
         return false;
      }
      
      public function get editable() : Boolean
      {
         return var_2648;
      }
      
      public function set editable(param1:Boolean) : void
      {
         var_2648 = param1;
         _field.type = param1 && isEnabled() ? "input" : "dynamic";
      }
      
      public function get selectable() : Boolean
      {
         return _field.selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         _field.selectable = param1;
      }
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         _field.displayAsPassword = param1;
      }
      
      public function get displayAsPassword() : Boolean
      {
         return _field.displayAsPassword;
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
         throw new Error("Unimplemented method!");
      }
      
      public function getMouseCursorByState(param1:uint) : uint
      {
         throw new Error("Unimplemented method!");
      }
      
      public function showToolTip(param1:IToolTipWindow) : void
      {
         throw new Error("Unimplemented method!");
      }
      
      public function hideToolTip() : void
      {
         throw new Error("Unimplemented method!");
      }
      
      override public function set autoSize(param1:String) : void
      {
         super.autoSize = param1;
         refreshAutoSize();
      }
      
      override public function set background(param1:Boolean) : void
      {
         _field.background = param1;
         _background = param1;
         _fillColor = _background ? _fillColor | _alphaColor : _fillColor & 0xFFFFFF;
      }
      
      public function setSelection(param1:int, param2:int) : void
      {
         _field.setSelection(param1,param2);
      }
      
      public function get selectionBeginIndex() : int
      {
         return _field.selectionBeginIndex;
      }
      
      public function get selectionEndIndex() : int
      {
         return _field.selectionEndIndex;
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !var_43)
         {
            var_43 = new GraphicContext("GC {" + _name + "}",2,rectangle);
         }
         return var_43;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            _context.getWindowServices().getFocusManagerService().removeFocusWindow(this);
            var_1792 = false;
            if(_field)
            {
               if(focused)
               {
                  unfocus();
               }
               _field.removeEventListener("keyDown",onKeyDownEvent);
               _field.removeEventListener("keyUp",onKeyUpEvent);
               _field.removeEventListener("change",onChangeEvent);
               _field.removeEventListener("focusIn",onFocusEvent);
               _field.removeEventListener("focusOut",onFocusEvent);
               _field.removeEventListener("removedFromStage",onRemovedEvent);
            }
            super.dispose();
         }
      }
      
      override public function set text(param1:String) : void
      {
         super.text = param1;
         refreshAutoSize();
      }
      
      override public function focus() : Boolean
      {
         var _loc1_:Boolean = super.focus();
         if(_loc1_)
         {
            if(_field)
            {
               if(_field.stage)
               {
                  if(_field.stage.focus != _field)
                  {
                     _field.stage.focus = _field;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      override public function unfocus() : Boolean
      {
         if(_field)
         {
            if(_field.stage)
            {
               if(_field.stage.focus == _field)
               {
                  _field.stage.focus = null;
               }
            }
         }
         return super.unfocus();
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         switch(param2.type)
         {
            case "WE_ACTIVATED":
            case "WME_DOWN":
               focus();
               break;
            case "WE_RESIZED":
               if(param1 == this)
               {
                  _field.width = this.width;
                  _field.height = this.height;
               }
         }
         if(param1 == this)
         {
            InteractiveController.processInteractiveWindowEvents(this,param2);
         }
         return _loc3_;
      }
      
      protected function refreshAutoSize() : void
      {
         var _loc2_:Point = null;
         var _loc1_:Point = null;
         if(var_704 && autoSize != "none" && !(this is HTMLTextController))
         {
            if(var_29 != _field.width || var_32 != _field.height)
            {
               _loc2_ = _field.localToGlobal(new Point(_field.x,_field.y));
               var _loc3_:Point = new Point();
               getGlobalPosition(_loc3_);
               _loc1_ = new Point(_loc2_.x - _loc3_.x,_loc2_.y - _loc3_.y);
               setRectangle(var_25 + _loc1_.x,var_26 + _loc1_.y,_field.width,_field.height);
            }
         }
      }
      
      override public function set filters(param1:Array) : void
      {
         var_2018 = true;
         _filters = param1;
         updateFilters();
      }
      
      override public function get filters() : Array
      {
         return _filters;
      }
      
      override public function set etchingColor(param1:uint) : void
      {
         var_2018 = true;
         super.etchingColor = param1;
      }
      
      private function updateFilters() : void
      {
         if(!var_2018)
         {
            return;
         }
         var_2018 = false;
         if((_etchingColor & 0xFF000000) != 0)
         {
            var_3251.color = _etchingColor & 0xFFFFFF;
            var_3251.alpha = (_etchingColor >> 24 & 0xFF) / 255;
            var _loc1_:Array = _filters.slice();
            null.push(var_3251);
            getGraphicContext(true).filters = null;
         }
         else
         {
            getGraphicContext(true).filters = _filters;
         }
      }
      
      override protected function refreshTextImage(param1:Boolean = false) : void
      {
         var _loc3_:class_1758 = null;
         updateFilters();
         if(var_29 != _field.width)
         {
            if(autoSize != "none")
            {
               width = _field.width;
               var _loc2_:Boolean = true;
            }
            else
            {
               _field.width = width;
            }
         }
         if(var_32 != _field.height)
         {
            if(autoSize != "none")
            {
               height = _field.height;
               _loc2_ = true;
            }
            else
            {
               _field.height = height;
            }
         }
         if(!param1 && name_1)
         {
            _loc3_ = class_1758.allocate("WE_RESIZED",this,null);
            name_1.dispatchEvent(_loc3_);
            _loc3_.recycle();
         }
      }
      
      private function onTextInputEvent(param1:TextEvent) : void
      {
         if(hasTooManyLines(param1.text))
         {
            param1.preventDefault();
         }
      }
      
      private function hasTooManyLines(param1:String) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:* = false;
         if(multiline && maxLines > 0)
         {
            _loc4_ = numLines > maxLines;
            if(param1 != null)
            {
               _loc2_ = _field.text;
               _loc3_ = _field.caretIndex;
               _field.text = _loc2_.substring(0,_loc3_) + param1 + _loc2_.substring(_loc3_,_loc2_.length);
               if(numLines > maxLines)
               {
                  _loc4_ = true;
               }
               _field.text = _loc2_;
            }
         }
         return _loc4_;
      }
      
      private function onKeyDownEvent(param1:KeyboardEvent) : void
      {
         try
         {
            _caption = _field.text;
            var _loc3_:WindowKeyboardEvent = WindowKeyboardEvent.allocate("WKE_KEY_DOWN",param1,this,null);
            update(this,null);
            if(disposed)
            {
               return;
            }
            for each(var _loc2_ in _context.inputEventTrackers)
            {
               _loc2_.eventReceived(null,this);
            }
            null.recycle();
         }
         catch(e:Error)
         {
            _context.handleError(5,e);
         }
      }
      
      private function onKeyUpEvent(param1:KeyboardEvent) : void
      {
         try
         {
            _caption = _field.text;
            var _loc3_:WindowKeyboardEvent = WindowKeyboardEvent.allocate("WKE_KEY_UP",param1,this,null);
            update(this,null);
            if(disposed)
            {
               return;
            }
            for each(var _loc2_ in _context.inputEventTrackers)
            {
               _loc2_.eventReceived(null,this);
            }
            null.recycle();
         }
         catch(e:Error)
         {
            _context.handleError(5,e);
         }
      }
      
      public function requestChangeEvent() : void
      {
         onChangeEvent(null);
      }
      
      private function onChangeEvent(param1:Event) : void
      {
         var _loc2_:class_1758 = null;
         try
         {
            refreshAutoSize();
            _loc2_ = class_1758.allocate("WE_CHANGE",this,null);
            update(this,_loc2_);
            _loc2_.recycle();
         }
         catch(e:Error)
         {
            _context.handleError(5,e);
         }
      }
      
      private function onFocusEvent(param1:FocusEvent) : void
      {
         try
         {
            if(param1.type == "focusIn")
            {
               if(!getStateFlag(2))
               {
                  focus();
               }
            }
            else if(param1.type == "focusOut")
            {
               if(getStateFlag(2))
               {
                  unfocus();
               }
            }
         }
         catch(e:Error)
         {
            _context.handleError(5,e);
         }
      }
      
      private function onRemovedEvent(param1:Event) : void
      {
         try
         {
            if(getStateFlag(2))
            {
               unfocus();
            }
         }
         catch(e:Error)
         {
            _context.handleError(5,e);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = InteractiveController.writeInteractiveWindowProperties(this,super.properties);
         _loc1_.push(createProperty("editable",var_2648));
         _loc1_.push(createProperty("focus_capturer",var_1792));
         _loc1_.push(createProperty("selectable",_field.selectable));
         _loc1_.push(createProperty("display_as_password",_field.displayAsPassword));
         _loc1_.push(createProperty("display_raw",var_1067));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         InteractiveController.readInteractiveWindowProperties(this,param1);
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "focus_capturer":
                  var_1792 = _loc2_.value as Boolean;
                  if(var_1792)
                  {
                     _context.getWindowServices().getFocusManagerService().registerFocusWindow(this);
                  }
                  break;
               case "selectable":
                  _field.selectable = _loc2_.value as Boolean;
                  break;
               case "editable":
                  editable = _loc2_.value;
                  break;
               case "display_as_password":
                  _field.displayAsPassword = _loc2_.value as Boolean;
                  break;
               case "display_raw":
                  var_1067 = _loc2_.value as Boolean;
            }
         }
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
      
      public function set displayRaw(param1:Boolean) : void
      {
         var_1067 = param1;
      }
      
      public function get displayRaw() : Boolean
      {
         return var_1067;
      }
      
      override public function set localization(param1:String) : void
      {
         super.localization = var_1067 ? _caption : param1;
      }
      
      public function getWordAt(param1:int, param2:int) : String
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:int = getCharIndexAtPoint(param1,param2);
         var _loc6_:String = _field.text;
         var _loc4_:Array = getWordPositions(_loc6_);
         var _loc7_:String = "";
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc8_ = int(_loc4_[_loc5_]);
            _loc9_ = _loc6_.length;
            if(_loc5_ + 1 < _loc4_.length)
            {
               _loc9_ = _loc4_[_loc5_ + 1] - 1;
            }
            if(_loc3_ >= _loc8_ && _loc3_ <= _loc9_)
            {
               _loc7_ = _loc6_.substring(_loc8_,_loc9_);
               break;
            }
            _loc5_++;
         }
         return _loc7_;
      }
   }
}

