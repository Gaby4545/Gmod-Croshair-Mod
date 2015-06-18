
if not file.IsDir( "data", "DATA" ) then
file.CreateDir( "data", "DATA" )
end

local userDataFile = "data/crosshair.txt"
local playerData = util.JSONToTable( file.Read( userDataFile, "DATA" ) )
 
local crosshair = {}	
		
function crosshair:Init()
	self:SetSize(ScrW(), ScrH())
end
function crosshair:Paint()
	
	draw.RoundedBox (0, ScrW()/2, ScrH()/2, 50, 500, playerData.color)
end

		
	local ply = LocalPlayer()
	 
	local speed = ply:GetSpeed()
	local color = team.GetColor(ply:Team())

		local menu = vgui.Create( "DFrame" )
			menu:SetPos( ScrW()/2 - 575, ScrH()/2 - 760 )	
			menu:SetSize( 760, 575 )
			menu:SetTitle("")
			menu:MakePopup()
			menu:SetSizable( false )
			menu:SetDraggable( true )
			menu:ShowCloseButton( true )
			menu:SetBackgroundBlur( true )	

			
		local mixer = vgui.Create( "DColorMixer", menu )
			mixer:SetPos( 5, 30 )		
			mixer:SetSize( 257, 186 )		
			mixer:SetPalette( true ) 		--Show/hide the palette				DEF:true
			mixer:SetAlphaBar( true ) 		--Show/hide the alpha bar			DEF:true
			mixer:SetWangs( true )			--Show/hide the R G B A indicators 	DEF:true
			mixer:SetColor( playerData.color )	--Set the default color
	
	function menu:Paint( w, h )
		draw.RoundedBox (4, 0, 0, w, h, Color(10, 10, 10, 220 ))
		draw.RoundedBox (4, 0, 0, w, 25, color, true, true, false, false)
		draw.SimpleText( "Setting", "Default", 6, 2, color_white, 0, 0 ) -- Replace the title

		draw.RoundedBox (0, 420, 90, 120, 120, color_white )
		
		
		draw.RoundedBox (0, 500, 100, 5, 50, mixer:GetColor())
		draw.RoundedBox (0, 500, 170, 5, 50, mixer:GetColor())
	end
	
		local fov = vgui.Create( "DNumSlider", menu )
			fov:SetPos( 20, 250 )			 				-- Set the position
			fov:SetSize( 300, 10 )		 					-- Set the size
			fov:SetText( "Field of view" )					-- Set the text above the slider
			fov:SetMin( 75 )								-- Set the minimum number you can slide to
			fov:SetMax( 90 )								-- Set the maximum number you can slide to
			fov:SetDecimals( 0 )							-- Decimal places - zero for whole number
			fov:SetConVar( "fov_desired" ) 					-- Changes the ConVar when you slide
	
		local saveBt = vgui.Create( "DButton", menu )	-- Create the button
			saveBt:SetText( "Save" )				 	-- Set the text on the button
			saveBt:SetPos( 660, 530 )					-- Set the position on the frame
			saveBt:SetSize( 60, 25 )				 	-- Set the size		
			saveBt.DoClick = function()			 		-- A custom function run when clicked ( note: it a . instead of : )

				if file.Exists( userDataFile, "DATA" ) then
					local playerData = util.JSONToTable( file.Read( userDataFile, "DATA" ) )
						playerData.color = mixer:GetColor()
					file.Write( userDataFile, util.TableToJSON( playerData ) )
				else
				local data = {
						color = mixer:GetColor(),
						}
						file.Write( userDataFile, util.TableToJSON( data ) )
				end
			end

hook.Add( "Tick", "CheckPlyOpenKey", function()
	if ( ply:KeyPressed( crosshaircfg.openkey ) ) then
		menu.MakePopup()
	end
end )