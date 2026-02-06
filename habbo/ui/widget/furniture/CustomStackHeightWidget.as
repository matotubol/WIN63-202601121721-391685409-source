package com.sulake.habbo.ui.widget.furniture
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.class_2833;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetCustomStackingHeightComposer;
   
   public class CustomStackHeightWidget extends RoomWidgetBase
   {
      
      private static const SLIDER_RANGE:int = 10;
      
      private static const MAX_HEIGHT:int = 80;
      
      private static const SLIDER_BUTTON_WIDTH:int = 20;
      
      private var _window:class_1812;
      
      private var var_2536:int;
      
      private var _ignoreCheckboxEvents:Boolean;
      
      public function CustomStackHeightWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super(param1,param2,param3,param4);
         class_2833(param1).widget = this;
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         super.dispose();
      }
      
      override public function get mainWindow() : class_1741
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = class_1812(windowManager.buildFromXML(XML(assets.getAssetByName("custom_stack_height_xml").content)));
            _window.procedure = windowProcedure;
            _window.center();
            multiWalkCheckbox.addEventListener("WE_SELECTED",onMultiWalkChange);
            multiWalkCheckbox.addEventListener("WE_UNSELECTED",onMultiWalkChange);
         }
      }
      
      private function onMultiWalkChange(param1:class_1758) : void
      {
         if(_ignoreCheckboxEvents)
         {
            return;
         }
         handler.container.connection.send(new SetCustomStackingHeightComposer([var_2536,currentHeight,multiWalkMode]));
      }
      
      public function open(param1:int, param2:Number, param3:Boolean, param4:Boolean) : void
      {
         var_2536 = param1;
         param2 = Math.min(param2,80);
         if(_window == null)
         {
            createWindow();
         }
         walkTileContainer.visible = param3;
         if(param3)
         {
            _ignoreCheckboxEvents = true;
            if(param4)
            {
               multiWalkCheckbox.select();
            }
            else
            {
               multiWalkCheckbox.unselect();
            }
            _ignoreCheckboxEvents = false;
         }
         _window.height = param3 ? _window.limits.maxHeight : int(_window.limits.minHeight);
         var _loc5_:String = param3 ? "walk" : "stack";
         _window.caption = localizations.getLocalization("widget.custom." + _loc5_ + ".height.title");
         _window.findChildByName("height_text").caption = localizations.getLocalization("widget.custom." + _loc5_ + ".height.text");
         _window.findChildByName("input_height").caption = param2.toString();
         updateSlider();
         _window.visible = true;
      }
      
      public function hide() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.visible = false;
      }
      
      private function destroyWindow() : void
      {
         if(_window)
         {
            _window.procedure = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_floor_level":
                  altitude = 0;
                  sendCurrentHeight();
                  break;
               case "button_above_stack":
                  handler.container.connection.send(new SetCustomStackingHeightComposer([var_2536,-100]));
                  break;
               case "header_button_close":
                  destroyWindow();
                  break;
               case "slider":
                  _window.findChildByName("slider_button").x = WindowMouseEvent(param1).localX;
                  sendCurrentHeight();
            }
         }
         else if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
         {
            var _loc3_:* = param2.name;
            if("slider_button" === _loc3_)
            {
               sendCurrentHeight();
            }
         }
         else if(param1.type == "WME_DOUBLE_CLICK")
         {
            _loc3_ = param2.name;
            if("slider_button" === _loc3_)
            {
               updateHeightSelection(true);
               sendCurrentHeight();
            }
         }
         else if(param1.type == "WE_RELOCATED")
         {
            _loc3_ = param2.name;
            if("slider_button" === _loc3_)
            {
               updateHeightSelection();
            }
         }
         else if(param1.type == "WKE_KEY_DOWN")
         {
            if(param2.name == "input_height")
            {
               if(WindowKeyboardEvent(param1).keyCode == 13)
               {
                  updateSlider();
                  sendCurrentHeight();
               }
            }
         }
      }
      
      private function sendCurrentHeight() : void
      {
         handler.container.connection.send(new SetCustomStackingHeightComposer([var_2536,currentHeight]));
      }
      
      private function get currentHeight() : int
      {
         return parseFloat(_window.findChildByName("input_height").caption) * 100;
      }
      
      private function get multiWalkMode() : Boolean
      {
         return multiWalkCheckbox.isSelected;
      }
      
      private function updateSlider() : void
      {
         var _loc3_:Number = parseFloat(_window.findChildByName("input_height").caption);
         var _loc1_:Number = _loc3_ / 10;
         _loc1_ = Math.min(_loc1_,1);
         var _loc2_:Number = _window.findChildByName("slider").width - 20;
         _window.procedure = null;
         _window.findChildByName("slider_button").x = _loc2_ * _loc1_;
         _window.procedure = windowProcedure;
      }
      
      private function updateHeightSelection(param1:Boolean = false) : void
      {
         var _loc4_:int = param1 ? 1 : 100;
         var _loc3_:Number = _window.findChildByName("slider").width - 20;
         var _loc2_:Number = _window.findChildByName("slider_button").x / _loc3_;
         var _loc5_:Number = _loc2_ * 10 * _loc4_;
         _window.findChildByName("input_height").caption = (int(_loc5_) / (_loc4_ * 1)).toString();
      }
      
      private function get handler() : class_2833
      {
         return var_41 as class_2833;
      }
      
      private function set altitude(param1:Number) : void
      {
         if(_window != null)
         {
            _window.findChildByName("input_height").caption = param1.toString();
            updateSlider();
         }
      }
      
      public function updateHeight(param1:int, param2:Number) : void
      {
         if(var_2536 == param1)
         {
            altitude = param2;
         }
      }
      
      private function get walkTileContainer() : class_1812
      {
         return _window.findChildByName("walktile_container") as class_1812;
      }
      
      private function get multiWalkCheckbox() : class_1885
      {
         return _window.findChildByName("multiwalk_checkbox") as class_1885;
      }
   }
}

