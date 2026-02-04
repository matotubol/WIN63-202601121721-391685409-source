package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEventPresetItem;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   
   public class DimmerFurniWidget extends RoomWidgetBase
   {
      
      private static const AVAILABLE_COLORS:Array = new Array(7665141,21495,15161822,15353138,15923281,8581961,0);
      
      private static const const_24:Array = new Array(76,76);
      
      private var var_18:DimmerView;
      
      private var var_1484:Array;
      
      private var var_2151:int;
      
      private var var_5124:int;
      
      private var var_2200:int;
      
      private var _color:uint = 16777215;
      
      private var var_2670:uint = 255;
      
      private var var_2529:int;
      
      private var var_1468:Boolean;
      
      public function DimmerFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get isOn() : Boolean
      {
         return var_1468;
      }
      
      public function get presets() : Array
      {
         return var_1484;
      }
      
      public function get colors() : Array
      {
         return AVAILABLE_COLORS;
      }
      
      public function get minLights() : Array
      {
         return const_24;
      }
      
      public function get selectedPresetIndex() : int
      {
         return var_2151;
      }
      
      public function set selectedPresetIndex(param1:int) : void
      {
         var_2151 = param1;
      }
      
      override public function dispose() : void
      {
         disposeInterface();
         var_1484 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWDUE_PRESETS",onPresets);
         param1.addEventListener("RWDUE_HIDE",onHide);
         param1.addEventListener("RWDSUE_DIMMER_STATE",onDimmerState);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWDUE_PRESETS",onPresets);
         param1.removeEventListener("RWDUE_HIDE",onHide);
         param1.removeEventListener("RWDSUE_DIMMER_STATE",onDimmerState);
      }
      
      private function onPresets(param1:RoomWidgetDimmerUpdateEvent) : void
      {
         var_2529 = param1.itemId;
         var_1468 = param1.isOn;
         var_2151 = param1.selectedPresetId - 1;
         var_1484 = [];
         var _loc3_:int = 0;
         while(0 < param1.presets.length)
         {
            var _loc4_:RoomWidgetDimmerUpdateEventPresetItem = param1.presets[0];
            var _loc2_:DimmerFurniWidgetPresetItem = new DimmerFurniWidgetPresetItem(null.id,null.type,null.color,null.light);
            var_1484.push(null);
            _loc3_++;
         }
         showInterface();
      }
      
      private function onHide(param1:RoomWidgetDimmerUpdateEvent) : void
      {
         if(var_2529 == param1.itemId)
         {
            disposeInterface();
         }
      }
      
      private function disposeInterface() : void
      {
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      private function onDimmerState(param1:RoomWidgetDimmerStateUpdateEvent) : void
      {
         var _loc2_:RoomWidgetDimmerPreviewMessage = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.state > 0)
         {
            var_5124 = param1.objectId;
         }
         if(var_5124 == param1.objectId)
         {
            var_2200 = param1.effectId;
            _color = param1.color;
            var_2670 = param1.brightness;
         }
         if(var_2529 == param1.objectId)
         {
            var_1468 = param1.state > 0;
         }
         if(var_18 != null)
         {
            var_18.update();
         }
         if(!validateBrightness(var_2670,var_2200))
         {
            return;
         }
         _loc2_ = new RoomWidgetDimmerPreviewMessage(_color,var_2670,var_2200 == 2);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      private function showInterface() : void
      {
         if(var_18 == null)
         {
            var_18 = new DimmerView(this);
         }
         if(var_18 != null)
         {
            var_18.showInterface();
         }
      }
      
      public function storeCurrentSetting(param1:Boolean) : void
      {
         var _loc6_:RoomWidgetDimmerSavePresetMessage = null;
         if(!var_1468)
         {
            return;
         }
         if(messageListener == null)
         {
            return;
         }
         var _loc7_:int = var_2151 + 1;
         if(var_1484 == null || _loc7_ < 0 || _loc7_ > var_1484.length)
         {
            return;
         }
         var _loc5_:int = var_18.selectedType;
         var _loc4_:uint = uint(colors[var_18.selectedColorIndex]);
         var _loc3_:int = var_18.selectedBrightness;
         var _loc2_:DimmerFurniWidgetPresetItem = var_1484[var_2151] as DimmerFurniWidgetPresetItem;
         if(_loc2_ != null && _loc2_.type == _loc5_ && _loc2_.color == _loc4_ && _loc2_.light == _loc3_ && !param1)
         {
            return;
         }
         _loc2_.type = _loc5_;
         _loc2_.color = _loc4_;
         _loc2_.light = _loc3_;
         if(!validateBrightness(_loc3_,_loc5_))
         {
            return;
         }
         _loc6_ = new RoomWidgetDimmerSavePresetMessage(_loc7_,_loc5_,_loc4_,_loc3_,param1,var_2529);
         messageListener.processWidgetMessage(_loc6_);
      }
      
      public function previewCurrentSetting() : void
      {
         var _loc1_:RoomWidgetDimmerPreviewMessage = null;
         if(!var_1468)
         {
            return;
         }
         if(messageListener == null)
         {
            return;
         }
         if(!validateBrightness(var_18.selectedBrightness,var_18.selectedType))
         {
            return;
         }
         _loc1_ = new RoomWidgetDimmerPreviewMessage(colors[var_18.selectedColorIndex],var_18.selectedBrightness,var_18.selectedType == 2);
         messageListener.processWidgetMessage(_loc1_);
      }
      
      public function changeRoomDimmerState() : void
      {
         var _loc1_:RoomWidgetDimmerChangeStateMessage = null;
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetDimmerChangeStateMessage(var_2529);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      public function removePreview() : void
      {
         var _loc1_:RoomWidgetDimmerPreviewMessage = null;
         if(messageListener == null)
         {
            return;
         }
         if(!validateBrightness(var_2670,var_2200))
         {
            return;
         }
         _loc1_ = new RoomWidgetDimmerPreviewMessage(_color,var_2670,var_2200 == 2);
         messageListener.processWidgetMessage(_loc1_);
      }
      
      private function validateBrightness(param1:uint, param2:int) : Boolean
      {
         return true;
      }
   }
}

