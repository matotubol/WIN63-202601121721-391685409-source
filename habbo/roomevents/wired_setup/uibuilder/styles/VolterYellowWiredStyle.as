package com.sulake.habbo.roomevents.wired_setup.uibuilder.styles
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class VolterYellowWiredStyle extends WiredStyle
   {
      
      public static const NAME:String = "volter_yellow";
      
      private var var_4693:class_1812;
      
      public function VolterYellowWiredStyle(param1:HabboUserDefinedRoomEvents)
      {
         super(param1);
         var_4693 = class_1812(param1.getXmlWindow("wired_style_volter_yellow"));
      }
      
      override protected function get styleTemplate() : class_1812
      {
         return var_4693;
      }
      
      override public function get radioButtonSpacing() : int
      {
         return 6;
      }
      
      override public function get checkboxSpacing() : int
      {
         return 2;
      }
      
      override public function get checkboxYOffset() : int
      {
         return 0;
      }
      
      override public function get genericHorizontalSpacing() : int
      {
         return 5;
      }
      
      override public function get genericVerticalSpacing() : int
      {
         return 5;
      }
      
      override public function get sectionSpacing() : int
      {
         return 4;
      }
      
      override public function get sectionLeftRightMargin() : int
      {
         return 5;
      }
      
      override public function get headerMargin() : int
      {
         return 5;
      }
      
      override public function get headerBottomMarginWithLink() : int
      {
         return 1;
      }
      
      override public function get headerNameFontSize() : int
      {
         return 9;
      }
      
      override public function get minimumOptionHeight() : int
      {
         return 20;
      }
      
      override public function get minimumOptionSpacing() : int
      {
         return 4;
      }
      
      override public function get optionExtraUnderSpacing() : int
      {
         return 3;
      }
      
      override public function get optionExtraUnderLeftMargin() : int
      {
         return 25;
      }
      
      override public function get LRContainerMargin() : int
      {
         return 9;
      }
      
      override public function get LRContainerSpacing() : int
      {
         return 6;
      }
      
      override public function get LRContainerTopBottomPadding() : int
      {
         return 4;
      }
      
      override public function get inputSourceListMinHeight() : int
      {
         return 23;
      }
      
      override public function get buttonRowSpacing() : int
      {
         return 12;
      }
      
      override public function get menuRightOffset() : int
      {
         return 12;
      }
      
      override public function get frameColor() : uint
      {
         return 16433664;
      }
      
      override public function get backgroundColor() : uint
      {
         return 16444028;
      }
      
      override public function get advancedBackgroundColor() : uint
      {
         return 16044639;
      }
      
      override public function get yellowTextColor() : uint
      {
         return 16777130;
      }
      
      override public function get name() : String
      {
         return "volter_yellow";
      }
      
      override public function get isVolter() : Boolean
      {
         return true;
      }
      
      override public function get useInnerBorder() : Boolean
      {
         return true;
      }
   }
}

