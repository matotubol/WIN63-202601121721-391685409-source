package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.HtmlTextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.HtmlPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class LevelXpPreviewPreset extends WiredUIPreset
   {
      
      private static var var_5367:Number = 9223372036854776000;
      
      private var _listPreset:SimpleListViewPreset;
      
      private var var_30:class_1812;
      
      private var _previewLevels:Array;
      
      private var var_2357:Vector.<HtmlPreset>;
      
      public function LevelXpPreviewPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         super(param1,param2,param3);
         _previewLevels = param4;
         var_2357 = new Vector.<HtmlPreset>();
         var _loc5_:Array = [];
         var _loc6_:HtmlTextParam = new HtmlTextParam(0);
         for each(var _loc7_ in _previewLevels)
         {
            var _loc8_:HtmlPreset = param2.createHtml(getText(_loc7_,"0"),_loc6_);
            var_2357.push(null);
            _loc5_.push(null);
         }
         _listPreset = param2.createSimpleListView(true,_loc5_);
         _listPreset.spacing = 1;
         var_30 = param2.createLayout("container_view") as class_1812;
         var_30.addChild(_listPreset.window);
      }
      
      private function getText(param1:int, param2:String) : String
      {
         return _roomEvents.localization.getLocalizationWithParams("wiredfurni.params.levelup.preview.entry","","lvl","<font color=\"" + yellowColorHex + "\">" + param1 + "</font>","xp","<font color=\"" + yellowColorHex + "\">" + param2 + "</font>");
      }
      
      private function get yellowColorHex() : String
      {
         return Util.uintToHexColor(var_64.yellowTextColor);
      }
      
      public function setPreviewXps(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:Number = NaN;
         _loc3_ = 0;
         while(_loc3_ < _previewLevels.length)
         {
            _loc2_ = int(_previewLevels[_loc3_]);
            _loc5_ = "Unreachable level";
            if(_loc3_ < param1.length)
            {
               _loc4_ = Number(param1[_loc3_]);
               if(_loc4_ > var_5367)
               {
                  _loc5_ = "Out of bounds";
               }
               else
               {
                  _loc5_ = Math.round(param1[_loc3_]).toString();
               }
            }
            var_2357[_loc3_].text = getText(_loc2_,_loc5_);
            _loc3_++;
         }
      }
      
      public function get previewLevels() : Array
      {
         return _previewLevels;
      }
      
      override public function get window() : class_1741
      {
         return var_30;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var_30.width = param1;
         _listPreset.resizeToWidth(param1);
         var_30.height = _listPreset.window.height;
      }
      
      override protected function get childPresets() : Array
      {
         return [_listPreset];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_30.dispose();
         var_30 = null;
         _listPreset = null;
         _previewLevels = null;
         var_2357 = null;
      }
   }
}

