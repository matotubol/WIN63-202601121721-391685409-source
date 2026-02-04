package com.sulake.core.window.components
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.iterators.ContainerIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.IMargins;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.TextMargins;
   import flash.geom.Rectangle;
   
   public class FrameController extends ContainerController implements class_2250
   {
      
      private static const TAG_TITLE_ELEMENT:String = "_TITLE";
      
      private static const TAG_HEADER_ELEMENT:String = "_HEADER";
      
      private static const TAG_CONTENT_ELEMENT:String = "_CONTENT";
      
      private static const TAG_SCALER_ELEMENT:String = "_SCALER";
      
      private var var_839:ILabelWindow;
      
      private var _header:class_2211;
      
      private var _content:class_1812;
      
      private var var_84:IMargins;
      
      private var var_1668:Boolean = false;
      
      private var var_1380:String = "";
      
      private var var_3783:Function = null;
      
      public function FrameController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 1;
         param4 = uint(param4 & ~0x10);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var_1668 = true;
         activate();
         setupScaling();
         var _loc12_:class_1741 = findChildByName("header_button_help");
         if(_loc12_ != null)
         {
            _loc12_.procedure = helpButtonProcedure;
         }
         helpPage = var_1380;
         menuButtonVisible = false;
      }
      
      public function get title() : ILabelWindow
      {
         return var_839 ? var_839 : (var_839 = ILabelWindow(findChildByTag("_TITLE")));
      }
      
      public function get header() : class_2211
      {
         return _header ? _header : (_header = class_2211(findChildByTag("_HEADER")));
      }
      
      public function get content() : class_1812
      {
         return _content ? _content : (_content = class_1812(findChildByTag("_CONTENT")));
      }
      
      public function get scaler() : IScalerWindow
      {
         return findChildByTag("_SCALER") as IScalerWindow;
      }
      
      public function get margins() : IMargins
      {
         if(!var_84)
         {
            var_84 = new TextMargins(content.left,content.top,content.right,content.bottom,marginsCallback);
         }
         return var_84;
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         try
         {
            title.text = param1;
         }
         catch(e:Error)
         {
         }
      }
      
      override public function set color(param1:uint) : void
      {
         super.color = param1;
         var _loc2_:Array = [];
         groupChildrenWithTag("_COLORIZE",_loc2_);
         for each(var _loc3_ in _loc2_)
         {
            _loc3_.color = param1;
         }
      }
      
      override public function get iterator() : IIterator
      {
         return content != null && var_1668 ? content.iterator : new ContainerIterator(this);
      }
      
      private function helpButtonProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK" && var_1380 != "" && var_3783 != null)
         {
            var_3783(var_1380);
         }
      }
      
      public function set helpButtonAction(param1:Function) : void
      {
         var_3783 = param1;
      }
      
      override public function buildFromXML(param1:XML, param2:class_55 = null) : Boolean
      {
         return context.getWindowParser().parseAndConstruct(param1,content,param2) != null;
      }
      
      override public function setParamFlag(param1:uint, param2:Boolean = true) : void
      {
         super.setParamFlag(param1,param2);
         setupScaling();
      }
      
      private function setupScaling() : void
      {
         var _loc1_:class_1741 = scaler;
         var _loc2_:Boolean = testParamFlag(65536);
         var _loc3_:Boolean = testParamFlag(8192);
         var _loc4_:Boolean = testParamFlag(4096);
         if(_loc1_)
         {
            if(_loc3_ || _loc2_)
            {
               _loc1_.setParamFlag(8192,true);
            }
            else
            {
               _loc1_.setParamFlag(8192,false);
            }
            if(_loc4_ || _loc2_)
            {
               _loc1_.setParamFlag(4096,true);
            }
            else
            {
               _loc1_.setParamFlag(4096,false);
            }
            _loc1_.visible = _loc3_ || _loc4_ || _loc2_;
         }
      }
      
      public function resizeToFitContent() : void
      {
         resizeToAccommodateChildren(content as WindowController);
      }
      
      private function marginsCallback(param1:IMargins) : void
      {
         var _loc2_:class_1741 = content;
         var _loc4_:uint = _loc2_.param;
         var _loc5_:uint = uint(_loc2_.param & (0xC0 | 0x0C00));
         if(_loc5_)
         {
            _loc2_.setParamFlag(0xC0 | 0x0C00,false);
         }
         var _loc3_:uint = uint(_loc2_.param & 0xC00000);
         if(_loc3_)
         {
            _loc2_.setParamFlag(12582912,false);
         }
         _loc2_.rectangle = new Rectangle(param1.left,param1.top,param1.right - param1.left,param1.bottom - param1.top);
         if(_loc5_ || _loc3_)
         {
            _loc2_.setParamFlag(4294967295,false);
            _loc2_.setParamFlag(_loc4_,true);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         var _loc2_:* = var_84 != null;
         _loc1_.push(new PropertyStruct("help_page",var_1380,"String",var_1380 != ""));
         _loc1_.push(new PropertyStruct("margin_left",content.left,"int",_loc2_));
         _loc1_.push(new PropertyStruct("margin_top",content.top,"int",_loc2_));
         _loc1_.push(new PropertyStruct("margin_right",var_29 - content.right,"int",_loc2_));
         _loc1_.push(new PropertyStruct("margin_bottom",var_32 - content.bottom,"int",_loc2_));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "help_page":
                  helpPage = _loc2_.value as String;
                  break;
               case "margin_left":
                  margins.left = _loc2_.value as int;
                  break;
               case "margin_top":
                  margins.top = _loc2_.value as int;
                  break;
               case "margin_right":
                  margins.right = var_29 - (_loc2_.value as int);
                  break;
               case "margin_bottom":
                  margins.bottom = var_32 - (_loc2_.value as int);
            }
         }
         super.properties = param1;
      }
      
      public function get helpPage() : String
      {
         return var_1380;
      }
      
      public function set helpPage(param1:String) : void
      {
         var_1380 = param1;
         var _loc2_:class_1741 = findChildByName("header_button_help");
         if(_loc2_ != null)
         {
            _loc2_.visible = var_1380 != "";
         }
      }
      
      public function get menuButton() : class_2483
      {
         return findChildByName("header_button_menu") as class_2483;
      }
      
      public function get menuButtonVisible() : Boolean
      {
         var _loc1_:class_2483 = menuButton;
         return _loc1_ != null && Boolean(_loc1_.visible);
      }
      
      public function set menuButtonVisible(param1:Boolean) : *
      {
         var _loc2_:class_2483 = menuButton;
         if(_loc2_ != null)
         {
            _loc2_.visible = param1;
         }
      }
   }
}

