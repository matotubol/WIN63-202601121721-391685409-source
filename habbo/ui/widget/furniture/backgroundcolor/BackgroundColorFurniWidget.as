package com.sulake.habbo.ui.widget.furniture.backgroundcolor
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureBackgroundColorWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.utils.ColorConverter;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetRoomBackgroundColorDataComposer;
   
   public class BackgroundColorFurniWidget extends RoomWidgetBase
   {
      
      private static const PARAMETER_HUE:String = "hue";
      
      private static const PARAMETER_SATURATION:String = "saturation";
      
      private static const PARAMETER_LIGHTNESS:String = "lightness";
      
      private var _window:class_2250;
      
      private var var_2536:int;
      
      private var _sliders:Vector.<BackgroundColorWidgetSlider> = new Vector.<BackgroundColorWidgetSlider>();
      
      private var var_1941:int;
      
      private var var_2016:int;
      
      private var var_1832:int;
      
      public function BackgroundColorFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null, param4:class_27 = null)
      {
         super(param1,param2,param3,param4);
         this.handler.widget = this;
      }
      
      public function get handler() : FurnitureBackgroundColorWidgetHandler
      {
         return var_41 as FurnitureBackgroundColorWidgetHandler;
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         super.dispose();
      }
      
      public function open(param1:int, param2:int, param3:int, param4:int) : void
      {
         var_2536 = param1;
         var_1941 = Math.max(param2,0);
         var_2016 = Math.max(param3,0);
         var_1832 = Math.max(param4,0);
         createWindow();
      }
      
      public function setParameterCallback(param1:String, param2:int) : void
      {
         switch(param1)
         {
            case "hue":
               var_1941 = param2;
               break;
            case "saturation":
               var_2016 = param2;
               break;
            case "lightness":
               var_1832 = param2;
         }
         renderColorPreview();
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = class_2250(windowManager.buildFromXML(assets.getAssetByName("background_color_ui_xml").content as XML));
            _window.procedure = windowProcedure;
            _window.center();
            _sliders.push(new BackgroundColorWidgetSlider(this,"hue",class_1812(_window.findChildByName("hue_container")),var_1941));
            _sliders.push(new BackgroundColorWidgetSlider(this,"saturation",class_1812(_window.findChildByName("saturation_container")),var_2016));
            _sliders.push(new BackgroundColorWidgetSlider(this,"lightness",class_1812(_window.findChildByName("lightness_container")),var_1832));
         }
      }
      
      private function destroyWindow() : void
      {
         for each(var _loc1_ in _sliders)
         {
            _loc1_.dispose();
         }
         _sliders = new Vector.<BackgroundColorWidgetSlider>();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function renderColorPreview() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc3_:class_2251 = class_2251(_window.findChildByName("color_preview_bitmap"));
         var _loc2_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,false);
         var _loc1_:uint = uint(ColorConverter.hslToRGB(((var_1941 & 0xFF) << 16) + ((var_2016 & 0xFF) << 8) + (var_1832 & 0xFF)));
         _loc2_.fillRect(_loc2_.rect,_loc1_);
         _loc3_.bitmap = _loc2_;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param2 != null && param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "apply_button":
                  handler.container.connection.send(new SetRoomBackgroundColorDataComposer(var_2536,var_1941,var_2016,var_1832));
                  break;
               case "on_off_button":
                  handler.container.connection.send(new UseFurnitureMessageComposer(var_2536));
                  break;
               case "header_button_close":
                  destroyWindow();
            }
         }
      }
   }
}

