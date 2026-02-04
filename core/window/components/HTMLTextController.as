package com.sulake.core.window.components
{
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.theme.class_2901;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.StyleSheet;
   
   public class HTMLTextController extends TextFieldController implements class_1899
   {
      
      private static const HTML_STYLESHEET_KEY:String = "html_stylesheet";
      
      private static var var_3662:String = "default";
      
      private var var_1943:String = "default";
      
      private var _htmlStyleSheetString:String = null;
      
      private var var_4268:StyleSheet = null;
      
      public function HTMLTextController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         immediateClickMode = true;
         if("allowedDomains" in _field)
         {
            _field["allowedDomains"] = new <String>["images.habbo.com","www.habbo.com","www.habbo.com.br","www.habbo.fi","www.habbo.fr","www.habbo.de","www.habbo.nl","www.habbo.es","www.habbo.it","www.habbo.com.tr","sandbox.habbo.com","duke.varoke.net","s1.varoke.net","d63.varoke.net","dev.varoke.net"];
         }
         _field.type = "dynamic";
         _field.mouseEnabled = true;
         _field.selectable = false;
         _field.mouseWheelEnabled = true;
      }
      
      public static function set defaultLinkTarget(param1:String) : void
      {
         var_3662 = param1;
      }
      
      public static function get defaultLinkTarget() : String
      {
         return var_3662;
      }
      
      private static function setHtmlStyleSheetString(param1:HTMLTextController, param2:String) : void
      {
         var _loc3_:StyleSheet = null;
         if(param1 == null)
         {
            return;
         }
         if(param1._htmlStyleSheetString == param2)
         {
            return;
         }
         param1._htmlStyleSheetString = param2;
         param1.var_4268 = null;
         if(param1._htmlStyleSheetString != null)
         {
            _loc3_ = new StyleSheet();
            _loc3_.parseCSS(param1._htmlStyleSheetString);
            param1.var_4268 = _loc3_;
         }
      }
      
      private static function convertLinksToEvents(param1:String) : String
      {
         var _loc2_:RegExp = null;
         _loc2_ = /<a[^>]+(http:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
         param1 = param1.replace(_loc2_,"<a href=\'event:$1\'>$2</a>");
         _loc2_ = /<a[^>]+(https:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
         return param1.replace(_loc2_,"<a href=\'event:$1\'>$2</a>");
      }
      
      private static function openWebPage(param1:String, param2:String) : void
      {
         var _loc5_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:URLRequest = null;
         if(param2 == null)
         {
            param2 = var_3662;
         }
         if(ExternalInterface.available)
         {
            try
            {
               _loc5_ = ExternalInterface.call("function() { return navigator.userAgent; }").toLowerCase();
            }
            catch(e:Error)
            {
               _loc5_ = "";
            }
            if(_loc5_.indexOf("safari") > -1 || _loc5_.indexOf("chrome") > -1 || _loc5_.indexOf("firefox") > -1 || _loc5_.indexOf("msie") > -1 && uint(_loc5_.substr(_loc5_.indexOf("msie") + 5,3)) >= 7)
            {
               try
               {
                  _loc3_ = ExternalInterface.call("function() {var win = window.open(\'" + param1 + "\', \'" + param2 + "\'); if (win) { win.focus();} return true; }");
               }
               catch(e:Error)
               {
               }
               if(_loc3_)
               {
                  return;
               }
            }
            _loc4_ = new URLRequest(param1);
            navigateToURL(_loc4_,param2);
         }
      }
      
      public function set linkTarget(param1:String) : void
      {
         if(class_2901.HTML_LINK_TARGET_RANGE.indexOf(param1) > -1)
         {
            var_1943 = param1;
         }
      }
      
      public function get linkTarget() : String
      {
         return var_1943 == "default" ? defaultLinkTarget : var_1943;
      }
      
      public function get htmlStyleSheetString() : String
      {
         return _htmlStyleSheetString;
      }
      
      public function set htmlStyleSheetString(param1:String) : void
      {
         setHtmlStyleSheetString(this,param1);
      }
      
      override public function set immediateClickMode(param1:Boolean) : void
      {
         if(param1 == var_2148 || _field == null)
         {
            return;
         }
         super.immediateClickMode = param1;
         if(var_2148)
         {
            _field.addEventListener("link",immediateClickHandler);
         }
         else
         {
            _field.removeEventListener("link",immediateClickHandler);
         }
      }
      
      override public function set text(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_localized)
         {
            context.removeLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            _localized = false;
         }
         _caption = param1;
         if(_caption.charAt(0) == "$" && _caption.charAt(1) == "{")
         {
            context.registerLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            _localized = true;
         }
         else if(_field != null)
         {
            _field.htmlText = convertLinksToEvents(_caption);
            refreshTextImage();
         }
      }
      
      override public function set localization(param1:String) : void
      {
         if(param1 != null && _field != null)
         {
            _field.htmlText = limitStringLength(convertLinksToEvents(param1));
            refreshTextImage();
         }
      }
      
      override public function set htmlText(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(_localized)
         {
            context.removeLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            _localized = false;
         }
         _caption = param1;
         if(_caption.charAt(0) == "$" && _caption.charAt(1) == "{")
         {
            context.registerLocalizationListener(_caption.slice(2,_caption.indexOf("}")),this);
            _localized = true;
         }
         else if(_field != null)
         {
            _field.htmlText = convertLinksToEvents(_caption);
            _field.styleSheet = var_4268;
            refreshTextImage();
         }
      }
      
      override protected function immediateClickHandler(param1:Event) : void
      {
         if(param1 is TextEvent)
         {
            var _loc4_:WindowLinkEvent = WindowLinkEvent.allocate(TextEvent(param1).text,this,null) as WindowLinkEvent;
            if(name_1)
            {
               name_1.dispatchEvent(null);
            }
            var _loc2_:Boolean = false;
            for each(var _loc3_ in _context.linkEventTrackers)
            {
               if(_loc3_.linkPattern.length > 0)
               {
                  if(null.link.substr(0,_loc3_.linkPattern.length) == _loc3_.linkPattern)
                  {
                     _loc3_.linkReceived(null.link);
                     _loc2_ = true;
                  }
               }
               else
               {
                  _loc3_.linkReceived(null.link);
               }
            }
            if(!null.isWindowOperationPrevented())
            {
               if(procedure != null)
               {
                  procedure(null,this);
               }
            }
            if(!null.isWindowOperationPrevented() && linkTarget != "internal")
            {
               openWebPage(TextEvent(param1).text,linkTarget);
            }
            param1.stopImmediatePropagation();
            null.recycle();
         }
         else
         {
            super.immediateClickHandler(param1);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = InteractiveController.writeInteractiveWindowProperties(this,super.properties);
         _loc1_.push(createProperty("editable",_field.type == "input"));
         _loc1_.push(createProperty("focus_capturer",var_1792));
         _loc1_.push(createProperty("selectable",_field.selectable));
         _loc1_.push(createProperty("display_as_password",_field.displayAsPassword));
         _loc1_.push(createProperty("display_raw",var_1067));
         _loc1_.push(createProperty("link_target",var_1943));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "link_target":
                  var_1943 = _loc2_.value as String;
                  break;
               case "html_stylesheet":
                  htmlStyleSheetString = _loc2_.value as String;
            }
         }
         super.properties = param1;
      }
      
      public function initializeLinkStyle() : void
      {
         var _loc5_:StyleSheet = new StyleSheet();
         var _loc1_:Object = {};
         _loc1_.color = "#0051a4";
         var _loc2_:Object = {};
         _loc2_.textDecoration = "underline";
         _loc2_.color = "#006de0";
         var _loc4_:Object = {};
         _loc4_.color = "#0053ad";
         var _loc3_:Object = {};
         _loc3_.textDecoration = "underline";
         _loc5_.setStyle("a:link",_loc2_);
         _loc5_.setStyle("a:hover",_loc1_);
         _loc5_.setStyle("a:active",_loc4_);
         _loc5_.setStyle(".visited",_loc3_);
         styleSheet = _loc5_;
      }
      
      override public function dispose() : void
      {
      }
   }
}

