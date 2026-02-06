package com.sulake.habbo.ui.widget.furniture.areahide
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomAreaSelectionManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureAreaHideWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetAreaHideDataComposer;
   
   public class AreaHideFurniWidget extends RoomWidgetBase
   {
      
      private static var AUTO_SAVE:Boolean = true;
      
      private static var var_4382:Array = ["hidearea_info","areaselection_title","areaselection_info","options_title","invisibility_txt","invisibility_info","wallitems_txt","invert_txt","invert_info"];
      
      private var var_1003:IRoomAreaSelectionManager;
      
      private var _window:class_2250;
      
      private var var_2042:int;
      
      private var var_1468:Boolean;
      
      private var var_1509:int;
      
      private var var_1754:int;
      
      private var _width:int;
      
      private var _length:int;
      
      private var var_1708:Boolean = false;
      
      private var var_2051:Boolean = false;
      
      private var var_798:Boolean = false;
      
      public function AreaHideFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:IRoomEngine)
      {
         super(param1,param2,param3,param4);
         this.handler.widget = this;
         var_1003 = param5.areaSelectionManager;
      }
      
      private static function disableElement(param1:Boolean, param2:class_1741) : void
      {
         if(param1)
         {
            param2.disable();
         }
         else
         {
            param2.enable();
         }
      }
      
      public function get handler() : FurnitureAreaHideWidgetHandler
      {
         return var_41 as FurnitureAreaHideWidgetHandler;
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         super.dispose();
      }
      
      public function open(param1:int, param2:Boolean, param3:int, param4:int, param5:int, param6:int, param7:Boolean, param8:Boolean, param9:Boolean) : void
      {
         var_2042 = param1;
         var_1468 = param2;
         var_1509 = param3;
         var_1754 = param4;
         _width = param5;
         _length = param6;
         createWindow();
         invisibilityCheckbox.isSelected = param7;
         wallItemsEnabledCheckbox.isSelected = param8;
         invertEnabledCheckbox.isSelected = param9;
         var_1708 = false;
         var_2051 = false;
         updateAreaSelecting();
         refreshUI();
      }
      
      private function get isActive() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      public function updateStatus(param1:int, param2:Boolean) : void
      {
         if(isActive && param1 == var_2042 && param2 != var_1468)
         {
            var_1468 = param2;
            updateAreaSelecting();
            refreshUI();
         }
      }
      
      private function updateAreaSelecting() : void
      {
         if(!var_1468)
         {
            if(!var_798)
            {
               var_798 = var_1003.activate(onAreaSelected,"highlight_darken");
            }
            if(var_798)
            {
               var_1003.setHighlight(var_1509,var_1754,_width,_length);
            }
         }
         else if(var_798)
         {
            var_1003.deactivate();
            var_798 = false;
         }
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = class_2250(windowManager.buildFromXML(assets.getAssetByName("area_hide_ui_xml").content as XML));
            _window.procedure = windowProcedure;
            invisibilityCheckbox.addEventListener("WE_SELECTED",onSettingsChanged);
            invisibilityCheckbox.addEventListener("WE_UNSELECTED",onSettingsChanged);
            wallItemsEnabledCheckbox.addEventListener("WE_SELECTED",onSettingsChanged);
            wallItemsEnabledCheckbox.addEventListener("WE_UNSELECTED",onSettingsChanged);
            invertEnabledCheckbox.addEventListener("WE_SELECTED",onSettingsChanged);
            invertEnabledCheckbox.addEventListener("WE_UNSELECTED",onSettingsChanged);
            applyButton.visible = !AUTO_SAVE;
            _window.center();
         }
         else
         {
            _window.visible = true;
         }
      }
      
      private function hideWindow() : void
      {
         if(_window)
         {
            _window.visible = false;
            if(var_798)
            {
               var_1003.deactivate();
               var_798 = false;
            }
            var_2042 = -1;
            var_1468 = false;
            var_1509 = 0;
            var_1754 = 0;
            _width = 0;
            _length = 0;
         }
      }
      
      private function destroyWindow() : void
      {
         hideWindow();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function refreshUI() : void
      {
         if(var_1468)
         {
            onOffButton.caption = localizations.getLocalization("widget.areahide.button.off");
            disableContents(true);
         }
         else
         {
            onOffButton.caption = localizations.getLocalization("widget.areahide.button.on");
            disableContents(false);
            disableElement(!var_1708,applyButton);
            disableElement(var_2051 || !var_798,selectButton);
            disableElement(!var_798,clearButton);
         }
      }
      
      private function disableContents(param1:Boolean) : void
      {
         var _loc3_:ITextWindow = null;
         disableElement(param1,selectButton);
         disableElement(param1,clearButton);
         disableElement(param1,applyButton);
         disableElement(param1,invisibilityCheckbox);
         invisibilityCheckbox.blend = param1 ? 0.5 : 1;
         disableElement(param1,wallItemsEnabledCheckbox);
         wallItemsEnabledCheckbox.blend = param1 ? 0.5 : 1;
         disableElement(param1,invertEnabledCheckbox);
         invertEnabledCheckbox.blend = param1 ? 0.5 : 1;
         for each(var _loc2_ in var_4382)
         {
            _loc3_ = _window.findChildByName(_loc2_) as ITextWindow;
            _loc3_.blend = param1 ? 0.5 : 1;
         }
      }
      
      private function onAreaSelected(param1:int, param2:int, param3:int, param4:int) : void
      {
         var_1509 = param1;
         var_1754 = param2;
         _width = param3;
         _length = param4;
         var_2051 = false;
         onSettingsChanged(null);
      }
      
      private function onClickSelect() : void
      {
         var_2051 = true;
         var_1003.startSelecting();
         refreshUI();
      }
      
      private function onClickClear() : void
      {
         var_1003.clearHighlight();
      }
      
      private function onClickOnOff() : void
      {
         handler.container.connection.send(new UseFurnitureMessageComposer(var_2042));
      }
      
      private function onClickApply() : void
      {
         if(!var_1708 || AUTO_SAVE)
         {
            return;
         }
         updateData();
         applyButton.disable();
      }
      
      private function updateData() : void
      {
         handler.container.connection.send(new SetAreaHideDataComposer(var_2042,var_1509,var_1754,_width,_length,invisibilityCheckbox.isSelected,wallItemsEnabledCheckbox.isSelected,invertEnabledCheckbox.isSelected));
         var_1708 = false;
      }
      
      private function onSettingsChanged(param1:class_1758) : void
      {
         var_1708 = true;
         if(AUTO_SAVE)
         {
            updateData();
         }
         refreshUI();
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param2 != null && param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "apply_button":
                  onClickApply();
                  break;
               case "on_off_button":
                  onClickOnOff();
                  break;
               case "select_button":
                  onClickSelect();
                  break;
               case "clear_button":
                  onClickClear();
                  break;
               case "header_button_close":
                  hideWindow();
            }
         }
      }
      
      private function get selectButton() : class_1775
      {
         _window.deactivate();
         return _window.findChildByName("select_button") as class_1775;
      }
      
      private function get clearButton() : class_1775
      {
         return _window.findChildByName("clear_button") as class_1775;
      }
      
      private function get applyButton() : class_1775
      {
         return _window.findChildByName("apply_button") as class_1775;
      }
      
      private function get onOffButton() : class_1775
      {
         return _window.findChildByName("on_off_button") as class_1775;
      }
      
      private function get invisibilityCheckbox() : class_1885
      {
         return _window.findChildByName("invisiblity_checkbox") as class_1885;
      }
      
      private function get wallItemsEnabledCheckbox() : class_1885
      {
         return _window.findChildByName("wallitems_checkbox") as class_1885;
      }
      
      private function get invertEnabledCheckbox() : class_1885
      {
         return _window.findChildByName("invert_checkbox") as class_1885;
      }
   }
}

