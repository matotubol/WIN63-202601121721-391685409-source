package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   
   public class CellTemplate
   {
      
      private var var_1369:IRegionWindow;
      
      private var _highlightBorderTemplate:class_1993;
      
      private var var_3612:ITextWindow;
      
      private var var_3695:ITextFieldWindow;
      
      private var var_3775:IRegionWindow;
      
      private var var_3451:IRegionWindow;
      
      public function CellTemplate(param1:IRegionWindow)
      {
         super();
         var_1369 = param1;
         _highlightBorderTemplate = param1.findChildByName("highlight_border") as class_1993;
         var_3612 = param1.findChildByName("element_text") as ITextWindow;
         var_3695 = param1.findChildByName("element_input") as ITextFieldWindow;
         var_3775 = param1.findChildByName("link_container") as IRegionWindow;
         var_3451 = param1.findChildByName("extra_button") as IRegionWindow;
         var_1369.removeChild(var_3451);
         var_1369.removeChild(var_3775);
         var_1369.removeChild(var_3695);
         var_1369.removeChild(var_3612);
         var_1369.removeChild(_highlightBorderTemplate);
      }
      
      public function clone() : IRegionWindow
      {
         return var_1369.clone() as IRegionWindow;
      }
      
      public function createHighlightBorder(param1:class_1812) : class_1993
      {
         return fixAlignmentsAndAdd(_highlightBorderTemplate,param1) as class_1993;
      }
      
      public function createElementText(param1:class_1812) : ITextWindow
      {
         return fixAlignmentsAndAdd(var_3612,param1) as ITextWindow;
      }
      
      public function createElementInput(param1:class_1812) : ITextFieldWindow
      {
         return fixAlignmentsAndAdd(var_3695,param1) as ITextFieldWindow;
      }
      
      public function createLinkContainer(param1:class_1812) : IRegionWindow
      {
         return fixAlignmentsAndAdd(var_3775,param1) as IRegionWindow;
      }
      
      public function createExtraButton(param1:class_1812) : IRegionWindow
      {
         return fixAlignmentsAndAdd(var_3451,param1) as IRegionWindow;
      }
      
      private function fixAlignmentsAndAdd(param1:class_1741, param2:class_1812) : class_1741
      {
         var _loc3_:int = param2.width - var_1369.width;
         var _loc4_:class_1741 = param1.clone();
         var _loc5_:uint = param1.param;
         var _loc6_:int = param1.x;
         var _loc8_:int = param1.width;
         var _loc7_:uint = uint(_loc5_ & 0xC0);
         if(_loc7_ == 128)
         {
            _loc8_ += _loc3_;
         }
         else if(_loc7_ == 64)
         {
            _loc6_ += _loc3_;
         }
         else if(_loc7_ == 192)
         {
            if(param2.width < param1.width && param1.getParamFlag(16))
            {
               _loc6_ = 0;
            }
            else
            {
               _loc6_ = Math.floor(param2.width / 2) - Math.floor(_loc8_ / 2);
            }
         }
         _loc4_.x = _loc6_;
         _loc4_.width = _loc8_;
         param2.addChild(_loc4_);
         return _loc4_;
      }
   }
}

