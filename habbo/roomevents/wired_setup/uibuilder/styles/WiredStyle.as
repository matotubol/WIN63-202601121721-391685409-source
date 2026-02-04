package com.sulake.habbo.roomevents.wired_setup.uibuilder.styles
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class WiredStyle
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function WiredStyle(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
      }
      
      protected function get styleTemplate() : class_1812
      {
         return null;
      }
      
      public function get radioButtonSpacing() : int
      {
         return 0;
      }
      
      public function get checkboxSpacing() : int
      {
         return 0;
      }
      
      public function get checkboxYOffset() : int
      {
         return 0;
      }
      
      public function get genericHorizontalSpacing() : int
      {
         return 0;
      }
      
      public function get genericVerticalSpacing() : int
      {
         return 0;
      }
      
      public function get sectionSpacing() : int
      {
         return 0;
      }
      
      public function get sectionLeftRightMargin() : int
      {
         return 0;
      }
      
      public function get headerMargin() : int
      {
         return 0;
      }
      
      public function get headerBottomMarginWithLink() : int
      {
         return 0;
      }
      
      public function get headerNameFontSize() : int
      {
         return 0;
      }
      
      public function get frameColor() : uint
      {
         return 0;
      }
      
      public function get backgroundColor() : uint
      {
         return 0;
      }
      
      public function get advancedBackgroundColor() : uint
      {
         return 0;
      }
      
      public function get yellowTextColor() : uint
      {
         return 0;
      }
      
      public function get softTextColor() : uint
      {
         return 0;
      }
      
      public function get minimumOptionHeight() : int
      {
         return 0;
      }
      
      public function get minimumOptionSpacing() : int
      {
         return 0;
      }
      
      public function get optionExtraUnderSpacing() : int
      {
         return 0;
      }
      
      public function get optionExtraUnderLeftMargin() : int
      {
         return 0;
      }
      
      public function get LRContainerMargin() : int
      {
         return 0;
      }
      
      public function get LRContainerSpacing() : int
      {
         return 0;
      }
      
      public function get LRContainerTopBottomPadding() : int
      {
         return 0;
      }
      
      public function get inputSourceListMinHeight() : int
      {
         return 0;
      }
      
      public function get buttonRowSpacing() : int
      {
         return 0;
      }
      
      public function get menuRightOffset() : int
      {
         return 0;
      }
      
      public function get name() : String
      {
         return "";
      }
      
      public function get isVolter() : Boolean
      {
         return false;
      }
      
      public function get useInnerBorder() : Boolean
      {
         return false;
      }
      
      public function createSplitterView() : class_1812
      {
         return recreateElement("ruler_view") as class_1812;
      }
      
      public function createTextView(param1:Boolean = true) : ITextWindow
      {
         return recreateElement(param1 ? "text_bold_view" : "text_view") as ITextWindow;
      }
      
      public function createHtmlView() : class_1899
      {
         return recreateElement("text_html") as class_1899;
      }
      
      public function createTextInputView() : class_1741
      {
         return recreateElement("input_template") as class_1741;
      }
      
      public function createCheckboxView() : class_1885
      {
         return recreateElement("checkbox_view") as class_1885;
      }
      
      public function createRadioButtonView() : IRadioButtonWindow
      {
         return recreateElement("radiobutton_view") as IRadioButtonWindow;
      }
      
      public function createExpandCollapseSectionRegion() : IRegionWindow
      {
         return recreateElement("expand_collapse_region") as IRegionWindow;
      }
      
      public function createSourceTypeSelector() : IItemListWindow
      {
         return recreateElement("sourcetype_selector_view") as IItemListWindow;
      }
      
      public function createDropdown() : class_2261
      {
         return recreateElement("dropdown_view") as class_2261;
      }
      
      public function createSlider() : class_1812
      {
         return recreateElement("slider") as class_1812;
      }
      
      public function createButton() : class_1775
      {
         return recreateElement("button") as class_1775;
      }
      
      public function createIconButton(param1:String) : class_1741
      {
         return recreateElement("iconbutton_" + param1);
      }
      
      public function createMiniButton() : class_1741
      {
         return recreateElement("mini_button_view");
      }
      
      public function createFrame() : class_2250
      {
         return recreateElement("frame") as class_2250;
      }
      
      public function createQuickMenu() : class_1812
      {
         return recreateElement("quick_menu") as class_1812;
      }
      
      public function createInnerBorder() : class_1993
      {
         return recreateElement("inner_border") as class_1993;
      }
      
      private function recreateElement(param1:String) : class_1741
      {
         var _loc2_:class_1741 = styleTemplate.findChildByName(param1);
         _loc2_ = _loc2_.clone();
         _loc2_.visible = true;
         return _loc2_;
      }
   }
}

