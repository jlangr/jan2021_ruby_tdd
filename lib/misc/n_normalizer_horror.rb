# split into consituent parts and normalize
# to allow appropriate sort for std reporting
class NNormalizerHorror
  def normalize(n)
    if n == "" # n is empty
      return n
    else
      # deal with excess commans
      if n.count(",") <= 1
        pts = nil
        sp = lambda {| i | (i != 0 ? " " : "")}
        b, sfx = n.split(",")
        pts = b.split(" ")
        penult = pts.length - 1 # all but last
        sz = penult
        m_pts = pts.slice(1..(penult - 1))
        ps = ""
        puts "parts #{m_pts}"
        m_pts.each_with_index do |m, i|
          if m.size > 1
            ps += sp.call(i) + "#{m[0]}."
          else
            ps = ps + (i > 0 ? " " : "") + m
          end
        end
        sfx = if sfx then
                   "," + "#{sfx}"  # append
                 else
                   ""
                 end
        mis = ps
        if pts.size > 1
          div = (pts.length - penult - 1)
          if pts.size < 3
            return "#{pts[-1]}, #{pts[0]}"
          elsif pts.size >= 3
            "#{pts[(pts.length) - 1]}, #{pts[0]} #{mis}#{sfx}"
          else
            raise ArgumentError.new("too many parts by % #{pts.size / div}")
          end
        else
          return n if pts.size == 1
        end
      else
        # comma count bad
        raise ArgumentError.new
      end
    end
  end
end
