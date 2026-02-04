package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SplitterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FooterPreset extends WiredUIPreset
   {
      
      private var _container:IItemListWindow;
      
      private var _splitter:SplitterPreset;
      
      private var var_34:ButtonRowPreset;
      
      private var var_541:ButtonPreset;
      
      public function FooterPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Function, param5:Function)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         _splitter = param2.createSplitter();
         var_541 = param2.createButton(loc("wiredfurni.ready"),param4);
         var _loc6_:ButtonPreset = param2.createButton(loc("cancel"),param5);
         var_34 = param2.createButtonRow([var_541,_loc6_]);
         var_34.window.x = param3.sectionLeftRightMargin;
         _container.spacing = var_64.sectionSpacing;
         _container.addListItem(_splitter.window);
         _container.addListItem(var_34.window);
         _container.background = true;
         _container.color = 0xFF000000 | var_64.frameColor;
      }
      
      public function set saveButtonDisabled(param1:Boolean) : void
      {
         var_541.disabled = param1;
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      public function set splitterVisible(param1:Boolean) : void
      {
         _splitter.visible = param1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         _splitter.resizeToWidth(param1);
         var_34.resizeToWidth(param1 - var_64.sectionLeftRightMargin * 2);
      }
      
      override protected function get childPresets() : Array
      {
         return [_splitter,var_34];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         _splitter = null;
         var_34 = null;
         var_541 = null;
      }
   }
}

