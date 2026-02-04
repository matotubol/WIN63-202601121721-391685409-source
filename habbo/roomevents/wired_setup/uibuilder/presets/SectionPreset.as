package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SectionPreset extends WiredUIPreset
   {
      
      private var _container:IItemListWindow;
      
      private var var_930:IItemListWindow;
      
      private var _headerContainer:class_1812;
      
      private var _headerOptionsRightList:IItemListWindow;
      
      private var _headerLeft:IItemListWindow;
      
      private var _expectedWidth:int;
      
      private var _splitter:SplitterPreset;
      
      private var var_839:TextPreset;
      
      private var _headerOptionsRight:Vector.<WiredUIPreset>;
      
      private var var_906:WiredUIPreset;
      
      private var _headerOptionLeft:WiredUIPreset;
      
      public function SectionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:WiredUIPreset, param6:SectionParam = null)
      {
         super(param1,param2,param3);
         if(param6 == null)
         {
            param6 = SectionParam.DEFAULT;
         }
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         var_930 = param2.createLayout("vertical_list_view") as IItemListWindow;
         _container.spacing = param3.sectionSpacing;
         var_930.spacing = param3.sectionSpacing;
         var_930.x = param3.sectionLeftRightMargin;
         _headerOptionsRight = new Vector.<WiredUIPreset>();
         _headerContainer = param2.createLayout("container_view") as class_1812;
         _headerLeft = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _headerLeft.spacing = param3.genericHorizontalSpacing;
         _headerOptionsRightList = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _headerOptionsRightList.spacing = param3.genericHorizontalSpacing;
         _splitter = param2.createSplitter();
         var_906 = param5;
         _headerOptionLeft = param6?.headerOptionLeft;
         var _loc7_:TextParam = new TextParam(_headerOptionLeft == null ? 1 : 0,true);
         var_839 = param2.createText(param4,_loc7_);
         _headerLeft.addListItem(var_839.window);
         if(_headerOptionLeft != null)
         {
            _headerLeft.addListItem(_headerOptionLeft.window);
         }
         _headerContainer.addChild(_headerLeft);
         _headerContainer.addChild(_headerOptionsRightList);
         _container.addListItem(_splitter.window);
         var_930.addListItem(_headerContainer);
         if(param6.expandMode != SectionParam.var_5352)
         {
            var_930.addListItem(var_906.window);
         }
         _container.addListItem(var_930);
         for each(var _loc10_ in param6.miscHeaderOptions)
         {
            addHeaderOption(_loc10_);
         }
         if(param6.sourceTypeSelectorParam != null)
         {
            var _loc8_:SourceTypeSelectorPreset = param2.createSourceTypeSelector(param6.sourceTypeSelectorParam);
            addHeaderOption(null);
         }
         if(param6.expandMode != SectionParam.var_5299)
         {
            var _loc9_:CollapseExpandSectionButtonPreset = param2.createCollapseExpandSectionButton(onExpandCollapseClicked,param6.expandMode == SectionParam.var_5298);
            addHeaderOption(null);
         }
      }
      
      public function addHeaderOption(param1:WiredUIPreset) : void
      {
         _headerOptionsRightList.addListItem(param1.window);
         _headerOptionsRight.push(param1);
      }
      
      public function onExpandCollapseClicked(param1:Boolean) : void
      {
         if(param1)
         {
            var_930.addListItem(var_906.window);
         }
         else
         {
            var_930.removeListItem(var_906.window);
         }
      }
      
      public function getSourceTypeSelector() : SourceTypeSelectorPreset
      {
         for each(var _loc1_ in _headerOptionsRight)
         {
            if(_loc1_ is SourceTypeSelectorPreset)
            {
               return _loc1_ as SourceTypeSelectorPreset;
            }
         }
         return null;
      }
      
      public function refreshAlignments() : void
      {
         resizeToWidth(_expectedWidth);
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _expectedWidth = param1;
         _container.width = param1;
         var _loc4_:int = param1 - 2 * var_64.sectionLeftRightMargin;
         _splitter.resizeToWidth(param1);
         var_906.resizeToWidth(_loc4_);
         var _loc3_:int = 0;
         for each(var _loc5_ in _headerOptionsRight)
         {
            _loc5_.resizeToWidth(_loc5_.staticWidth);
            if(_loc5_.window.bottom > _loc3_)
            {
               _loc3_ = _loc5_.window.bottom;
            }
         }
         _headerOptionsRightList.x = _loc4_ - _headerOptionsRightList.width;
         _headerOptionsRightList.height = _loc3_;
         var _loc2_:int = var_839.window.height;
         if(_headerOptionLeft != null)
         {
            _headerOptionLeft.resizeToWidth(_headerOptionLeft.staticWidth);
            var_839.resizeToWidth(var_839.staticWidth);
            if(_headerOptionLeft.window.height > _loc2_)
            {
               _loc2_ = _headerOptionLeft.window.height;
            }
         }
         else
         {
            var_839.resizeToWidth(_loc4_ - _headerOptionsRightList.width - var_64.genericHorizontalSpacing);
            _loc2_ = var_839.window.height;
         }
         _headerLeft.height = _loc2_;
         _headerContainer.width = _loc4_;
         _headerContainer.height = Math.max(_loc3_,_loc2_);
      }
      
      public function set titleText(param1:String) : void
      {
         var_839.text = param1;
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         var _loc1_:Array = [_splitter,var_839,var_906];
         if(_headerOptionLeft != null)
         {
            _loc1_.push(_headerOptionLeft);
         }
         if(_headerOptionsRight != null)
         {
            return _loc1_.concat(toArray(_headerOptionsRight));
         }
         return _loc1_;
      }
      
      public function set splitterVisible(param1:Boolean) : void
      {
         _splitter.visible = param1;
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
         var_930 = null;
         _headerContainer = null;
         _headerOptionsRightList = null;
         _splitter = null;
         var_839 = null;
         var_906 = null;
         _headerLeft = null;
         _headerOptionLeft = null;
      }
   }
}

