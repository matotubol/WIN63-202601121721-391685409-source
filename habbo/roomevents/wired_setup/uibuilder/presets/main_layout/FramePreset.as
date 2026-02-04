package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.class_4061;
   import com.sulake.habbo.roomevents.wired_setup.class_1928;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.*;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.MenuPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.MenuItem;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_99.class_2353;
   
   public class FramePreset extends WiredUIPreset
   {
      
      private static const MENU_COPY:int = 0;
      
      private static const MENU_PASTE:int = 1;
      
      private static const MENU_COPY_INTO:int = 2;
      
      private static const MENU_CLEAR_PICKS:int = 3;
      
      private static const MENU_RESET:int = 4;
      
      private static const MENU_OPEN_CREATOR_TOOLS:int = 5;
      
      private static const MENU_SAVE:int = 6;
      
      private static const MENU_CLOSE:int = 7;
      
      protected var _frame:class_2250;
      
      protected var _headerPreset:HeaderPreset;
      
      protected var _listPreset:SimpleListViewPreset;
      
      private var var_2595:Function;
      
      private var _holderKey:String;
      
      private var var_3602:int;
      
      private var _leftRightMargin:int;
      
      private var _topBottomMargin:int;
      
      private var _ignoreEvents:Boolean;
      
      private var var_433:MenuPreset;
      
      public function FramePreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:String, param7:int, param8:Boolean = false)
      {
         super(param1,param2,param3);
         var_2595 = param5;
         _holderKey = param6;
         var_3602 = param7;
         _frame = param3.createFrame();
         _leftRightMargin = _frame.width - _frame.margins.right + _frame.margins.left;
         _topBottomMargin = _frame.height - _frame.margins.bottom + _frame.margins.top;
         createListView(param4);
         _listPreset.window.addEventListener("WE_RESIZED",onContentsResized);
         _frame.findChildByTag("close").addEventListener("WME_CLICK",onCloseClicked);
         _frame.content.addChild(_listPreset.window);
         _frame.color = var_64.frameColor;
         if(param8)
         {
            _frame.setParamFlag(65536,true);
            _frame.addEventListener("WE_RESIZED",onFrameResized);
         }
         if(_frame.menuButton != null)
         {
            _frame.menuButtonVisible = true;
            _frame.menuButton.addEventListener("WME_CLICK",onMenuButtonClick);
         }
         createMenuPreset();
      }
      
      protected function createListView(param1:Array) : void
      {
         var _loc4_:SpacerPreset = null;
         var _loc5_:int = 0;
         var _loc6_:WiredUIPreset = null;
         var _loc3_:int = var_64.sectionSpacing;
         var _loc2_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = param1[_loc5_];
            if(_loc6_ is HeaderPreset)
            {
               _headerPreset = _loc6_ as HeaderPreset;
            }
            _loc2_.push(_loc6_);
            if(_loc5_ < param1.length - 1)
            {
               _loc4_ = var_182.createSpacer(_loc3_);
               _loc6_.blendSpacer = _loc4_;
               _loc2_.push(_loc4_);
            }
            _loc5_++;
         }
         _listPreset = var_182.createSimpleListView(true,_loc2_);
         _listPreset.spacing = 0;
         _listPreset.backgroundColor = var_64.backgroundColor;
      }
      
      private function onMenuButtonClick(param1:WindowMouseEvent) : void
      {
         var_433.requestOpen();
      }
      
      public function refreshForNewTriggerable() : void
      {
         var_433.setSelected(2,false);
         updateButtonDisabledStates();
      }
      
      public function updateButtonDisabledStates() : void
      {
         var _loc1_:class_1928 = _roomEvents.wiredCtrl;
         var _loc2_:Boolean = _roomEvents.wiredMenu.hasWritePermission;
         var_433.setDisabled(0,!_loc2_);
         var_433.setDisabled(1,!_loc2_ || !_loc1_.hasCurrentElementInClipboard());
         var_433.setDisabled(2,!_loc2_);
         var_433.setDisabled(3,!_loc2_ || _loc1_.getStuffIds().length + _loc1_.getStuffIds2().length == 0);
         var_433.setDisabled(4,!_loc2_);
         var_433.setDisabled(5,false);
         var_433.setDisabled(6,!_loc2_);
         var_433.setDisabled(7,false);
      }
      
      private function createMenuPreset() : void
      {
         var _loc1_:Array = [new MenuItem("${wiredfurni.params.menu.copy}",onCopyConfigMenuClick,"${wiredfurni.params.menu.copy_paste.tooltip}"),new MenuItem("${wiredfurni.params.menu.paste}",onPasteConfigMenuClick,"${wiredfurni.params.menu.copy_paste.tooltip}"),new MenuItem("${wiredfurni.params.menu.paste_into}",null,"${wiredfurni.params.menu.paste_into.tooltip}",true),MenuPreset.SPACER,new MenuItem("${wiredfurni.params.menu.clear_picks}",onClearPicksMenuClick),new MenuItem("${wiredfurni.params.menu.reset}",onResetMenuClick),MenuPreset.SPACER,new MenuItem("${wiredfurni.params.menu.open_menu}",onOpenMenuMenuClick),MenuPreset.SPACER,new MenuItem("${wiredfurni.params.menu.save}",onSaveMenuClick,"${wiredfurni.params.menu.save.tooltip}"),new MenuItem("${wiredfurni.params.menu.close}",onCloseMenuClick)];
         if(_holderKey == "action" && var_3602 == class_4061.RESET)
         {
            _loc1_.push(MenuPreset.SPACER);
            _loc1_.push(new MenuItem("Erase from existence",onEraseClick));
         }
         var_433 = var_182.createMenuPreset(_loc1_,_frame.menuButton);
      }
      
      private function onFrameResized(param1:class_1758) : void
      {
         if(!_ignoreEvents)
         {
            resizeToWidth(_frame.width);
         }
      }
      
      private function onContentsResized(param1:class_1758) : void
      {
         if(!_ignoreEvents)
         {
            fixHeight();
         }
      }
      
      private function onCloseClicked(param1:WindowMouseEvent) : void
      {
         if(var_2595 != null)
         {
            var_2595();
         }
      }
      
      public function get isCopyingIntoMode() : Boolean
      {
         return var_433.getSelected(2);
      }
      
      override public function get window() : class_1741
      {
         return _frame;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _ignoreEvents = true;
         _frame.width = param1;
         _listPreset.resizeToWidth(param1 - _leftRightMargin);
         _ignoreEvents = false;
         fixHeight();
      }
      
      private function get headerFrameBackground() : class_1741
      {
         return _frame.findChildByTag("wired_header_bg");
      }
      
      private function fixHeight() : void
      {
         _ignoreEvents = true;
         var _loc2_:int = _listPreset.window.height + _topBottomMargin;
         _frame.limits.minHeight = _loc2_;
         _frame.limits.maxHeight = _loc2_;
         _frame.height = _loc2_;
         _ignoreEvents = false;
         var _loc1_:class_1741 = headerFrameBackground;
         if(_loc1_ != null && _headerPreset != null)
         {
            _loc1_.height = _headerPreset.window.height + _frame.margins.top + var_64.sectionSpacing;
         }
      }
      
      override protected function get childPresets() : Array
      {
         return [_listPreset,var_433];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _frame.dispose();
         _frame = null;
         _listPreset = null;
         var_2595 = null;
         var_433 = null;
      }
      
      public function onCopyConfigMenuClick() : void
      {
         _roomEvents.wiredCtrl.createClipboardCopy();
      }
      
      public function onPasteConfigMenuClick() : void
      {
         _roomEvents.wiredCtrl.pasteFromClipboard();
      }
      
      public function onClearPicksMenuClick() : void
      {
         _roomEvents.wiredCtrl.clearStuffPicks();
      }
      
      public function onResetMenuClick() : void
      {
         _roomEvents.wiredCtrl.resetToDefault();
      }
      
      public function onOpenMenuMenuClick() : void
      {
         _roomEvents.context.createLinkEvent("wiredmenu/open");
      }
      
      public function onSaveMenuClick() : void
      {
         _roomEvents.wiredCtrl.update(1);
      }
      
      public function onCloseMenuClick() : void
      {
         _roomEvents.wiredCtrl.close();
      }
      
      public function onEraseClick() : void
      {
         _roomEvents.send(new class_2353("wf15",_holderKey + var_3602));
         _roomEvents.wiredCtrl.close();
      }
   }
}

