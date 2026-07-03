package com.rutong.framework.dao.objectquery;

import com.rutong.framework.utils.StringUtils;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.Order;
import jakarta.persistence.criteria.Root;

import java.util.ArrayList;
import java.util.List;

public class SortUtils {

	public static <T> List<Order> getSorts(CriteriaBuilder builder, Root<T> root, List<SortFilter> sorts) {
		List<Order> list = new ArrayList<>();
		if (sorts == null) {
			return list;
		}
		if (StringUtils.isNotEmpty(sorts)) {
			for (SortFilter sort : sorts) {
				Order order;
				if (sort.getDirection().equals(SortFilter.DESC)) {
					order = builder.desc(root.get(sort.getProperty()));
				} else {
					order = builder.asc(root.get(sort.getProperty()));
				}
				list.add(order);
			}
		}
		return list;
	}

}
