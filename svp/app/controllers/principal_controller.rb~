class PrincipalController < ApplicationController

  def inicio
    @sliders = Slider.order("RANDOM()")
    @pubs = Publicacion.order(indice: :asc).limit(3)
  end

  def acerca
    @title = "Acerca de"
  end

  def colaboradores
    @title = "Colaboradores"
    @personas = Persona.order(indice: :asc)
  end

  def seminarios
    @title = "Seminarios"
    @sems = Sesion.where("date_part('year', fecha_i) = ?", (params[:anio] ? params[:anio] : Sesion.maximum(:fecha_i).year.to_s)).order(fecha_i: :desc)
    @nxt = Sesion.where("date_part('year', fecha_i) = ?", (params[:anio] ? params[:anio].to_i + 1 : (Sesion.maximum(:fecha_i).year + 1).to_s)).size
    @lst = Sesion.where("date_part('year', fecha_i) = ?", (params[:anio] ? params[:anio].to_i - 1 : (Sesion.maximum(:fecha_i).year - 1).to_s)).size
    respond_to do |format|
      format.html
      format.js
    end
  end

  def seminario
    @sem = Sesion.where("regexp_replace(regexp_replace(regexp_replace(lower(unaccent(titulo)),'[^a-z0-9_]+','-','g'),'(.*)(-{1,})$','\\1'),'^(-{1,})?(.*)','\\2') = :sem", sem: params[:sem]).first
    @pubs = Publicacion.where(titulo: (JSON.parse(@sem.pubs).reject{|x| x.empty?}.size > 0 ? JSON.parse(@sem.pubs).reject{|x| x.empty?} : ",")).all
    @title = @sem.titulo
  end

  def publicaciones
    @title = "Publicaciones"
    @publicaciones = Publicacion.order(indice: :asc).limit(6).offset(params[:offset] ? params[:offset].to_i * 6 : 0)
    @total = Publicacion.count
    @pags = (@total / 6.0).ceil
    respond_to do |format|
      format.html
      format.js
    end
  end

  def publicacion
    @pub = Publicacion.where("regexp_replace(lower(unaccent(titulo)),'[^a-z0-9_]+','-','g') = ?", params[:pub]).first
    @title = @pub.titulo.gsub(/<.*?>/,"")
  end

  def multimedia
    @title = "Multimedia"
    @limite = 6
    @videos = Vid.limit(@limite).offset(params[:offset] ? params[:offset].to_i * @limite : 0).order(indice: :asc)
    @total = Vid.count
    respond_to do |format|
      format.html
      format.js
    end
  end
end
